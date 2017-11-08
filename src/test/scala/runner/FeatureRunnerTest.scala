package runner

import cucumber.api.CucumberOptions
import cucumber.api.junit.Cucumber
import org.junit.runner.RunWith

@RunWith(classOf[Cucumber])
@CucumberOptions(
  features = Array("classpath:features/StandardEvolution.feature"),
//  tags = Array("@Wip"),
  glue = Array("classpath:steps"),
  plugin = Array("pretty", "html:target/cucumber/html"))
class FeatureRunnerTest