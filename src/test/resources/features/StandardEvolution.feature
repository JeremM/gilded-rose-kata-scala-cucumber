Feature: Standard evolution feature
  - All items have a SellIn value which denotes the number of days we have to sell the item
  - All items have a Quality value which denotes how valuable the item is
  - At the end of each day our system lowers both values for every item
  - Once the sell by date has passed, Quality degrades twice as fast
  - The Quality of an item is never negative
  - "Aged Brie" actually increases in Quality the older it gets. It increase of 2 after sellIn date
  - The Quality of an item is never more than 50
  - "Sulfuras", being a legendary item, never has to be sold or decreases  in Quality
  - "Backstage passes", like aged brie, increases in Quality as it's SellIn value approaches;
  Quality increases by 2 when there are 10 days or less
  and by 3 when there are 5 days or less but Quality drops to 0 after the concert

  @StandardFeature
  Scenario: Standard evolution scenario
    Given I have the following items
      | name             | SellIn     | Quality  |
      | Aslak            | 12         | 10       |
      | Sword of tempest | 16         | 10       |
    When 2 days passes
    Then I can verify that I have the following items
      | name             | SellIn     | Quality  |
      | Aslak            | 10         | 8        |
      | Sword of tempest | 14         | 8        |

  @StandardFeature
  Scenario: Once the sell by date has passed, Quality degrades twice as fast
    Given I have the following items
      | name                  | SellIn     | Quality  |
      | Aslak                 | 3          | 12       |
      | Sword of tempest      | 5          | 10       |
    When 6 days passes
    Then I can verify that I have the following items
      | name             | SellIn      | Quality  |
      | Aslak            |  -3         | 3        |
      | Sword of tempest |  -1         | 3        |

  @StandardFeature
  Scenario: The Quality of an item is never negative
    Given I have the following items
      | name                  | SellIn     | Quality  |
      | Aslak                 | 3          | 12       |
      | Sword of tempest      | 5          | 4        |
    When 8 days passes
    Then I can verify that I have the following items
      | name             | SellIn      | Quality  |
      | Aslak            |  -5         | 0        |
      | Sword of tempest |  -3         | 0        |

  @StandardFeature
  Scenario: "Aged Brie" actually increases in Quality the older it gets. It increase of 2 after sellIn date
    Given I have the following items
      | name                  | SellIn     | Quality  |
      | Aslak                 | 5          | 12       |
      | Aged Brie             | 5          | 4        |
    When 6 days passes
    Then I can verify that I have the following items
      | name             | SellIn      | Quality  |
      | Aslak            |   -1        | 5        |
      | Aged Brie        |   -1        | 11       |

  @StandardFeature
  Scenario: The Quality of an item is never more than 50
    Given I have the following items
      | name                  | SellIn     | Quality  |
      | Aged Brie             | 20         | 40       |
    When 15 days passes
    Then I can verify that I have the following items
      | name             | SellIn      | Quality  |
      | Aged Brie        |   5         | 50       |

  @StandardFeature
  Scenario: "Sulfuras", being a legendary item, never has to be sold or decreases  in Quality
    Given I have the following items
      | name                        | SellIn     | Quality  |
      | Bear axe                    | 20         | 40       |
      | Sulfuras, Hand of Ragnaros  | 20         | 80       |
    When 15 days passes
    Then I can verify that I have the following items
      | name                        | SellIn     | Quality  |
      | Bear axe                    |   5        | 25       |
      | Sulfuras, Hand of Ragnaros  |   20       | 80       |

  @StandardFeature
  Scenario: Backstage passes, like aged brie, increases in Quality as it's SellIn value approaches;
    Given I have the following items
      | name                                       | SellIn     | Quality  |
      | Bear axe                                   | 20         | 40       |
      | Backstage passes to a TAFKAL80ETC concert  | 20         | 15       |
    When 5 days passes
    Then I can verify that I have the following items
      | name                                       | SellIn     | Quality  |
      | Bear axe                                   | 15         | 35       |
      | Backstage passes to a TAFKAL80ETC concert  | 15         | 20       |

  @StandardFeature
  Scenario: Backstage passes quality increases by 2 when there are 10 days or less
    Given I have the following items
      | name                                       | SellIn     | Quality  |
      | Bear axe                                   | 20         | 40       |
      | Backstage passes to a TAFKAL80ETC concert  | 15         | 15       |
    When 10 days passes
    Then I can verify that I have the following items
      | name                                       | SellIn     | Quality  |
      | Bear axe                                   | 10         | 30       |
      | Backstage passes to a TAFKAL80ETC concert  |  5         | 30       |

  @StandardFeature
  Scenario: Backstage passes quality increase by 3 when there are 5 days or less
    Given I have the following items
      | name                                       | SellIn     | Quality  |
      | Bear axe                                   | 20         | 40       |
      | Backstage passes to a TAFKAL80ETC concert  | 15         | 15       |
    When 13 days passes
    Then I can verify that I have the following items
      | name                                       | SellIn     | Quality  |
      | Bear axe                                   |  7         | 27       |
      | Backstage passes to a TAFKAL80ETC concert  |  2         | 39       |


  @StandardFeature
  Scenario: Backstage passes quality drops to 0 after the concer
    Given I have the following items
      | name                                       | SellIn     | Quality  |
      | Bear axe                                   | 20         | 40       |
      | Backstage passes to a TAFKAL80ETC concert  | 15         | 15       |
    When 16 days passes
    Then I can verify that I have the following items
      | name                                       | SellIn     | Quality  |
      | Bear axe                                   |   4        | 24       |
      | Backstage passes to a TAFKAL80ETC concert  |  -1        |  0       |