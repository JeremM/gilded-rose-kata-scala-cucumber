package steps

import cucumber.api.DataTable
import cucumber.api.scala.{EN, ScalaDsl}
import org.slf4j.LoggerFactory
import fr.jeremie.gildedrose._
import org.scalatest.FunSuite
import org.scalatest.Matchers._

class StandardSteps extends FunSuite with EN with ScalaDsl {
  private val log = LoggerFactory.getLogger(classOf[StandardSteps])

  private var gildedRose: GildedRose = _

  Given("""^I have the following items$""") { myParameters: DataTable =>
    val myItems = extractArrayOfItem(myParameters)
    gildedRose = new GildedRose(myItems)
  }

  When("""^(\d+) days passes$"""){ (nbDays:Int) =>
      for(i <- 1 to nbDays) gildedRose.updateQuality()
  }

  Then("""^I can verify that I have the following items$""") { myParameters: DataTable =>
    val myItemsToBeVerified = extractArrayOfItem(myParameters)
    myItemsToBeVerified.foreach(x => isInTheCurrentInn(x) shouldBe true)
  }

  def extractArrayOfItem(items: DataTable): Array[Item] = {
    items.raw().get(0).get(0) should be("name")
    items.raw().get(0).get(1) should be("SellIn")
    items.raw().get(0).get(2) should be("Quality")
    items.raw should not be empty
    var myTempList = List[Item]()
    items.raw.forEach(x => if (x.get(0) !== "name") myTempList ::= new Item(x.get(0), x.get(1).toInt, x.get(2).toInt))
    myTempList.toArray
  }

  def isInTheCurrentInn(itemToBeCompared: Item): Boolean = {
    var result = false
    gildedRose.items.foreach(x =>
      if (x.name === itemToBeCompared.name && x.sellIn === itemToBeCompared.sellIn && x.quality === itemToBeCompared.quality) result = true
    )
    result
  }

}
