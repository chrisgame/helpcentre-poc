Feature: The following scenarios should be possible for the benefits of search engines

  Scenario: All articles should appear in the sitemap.xml
    Given Mo has created the following articles
    When Mo creates an article associated with the product 'A'
    When Mo creates an article associated with the product 'B'
    When Mo creates an article associated with the product 'C'
    Then an entry for each article will exist in the sitemap

