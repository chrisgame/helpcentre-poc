Feature: The following scenarios should be possible for the benefits of search engines

  Scenario: All product pages should not appear in the sitemap.xml
    Given Mo is on the Create Article page
    When Mo creates an article associated with the product 'A'
    And Mo creates an article associated with the product 'B'
    And Mo creates an article associated with the product 'C'
    Then Mo should not see an entry for each of the products created in the sitemap

  Scenario: All individual articles should appear in the sitemap.xml
    Given Mo is on the Create Article page
    When Mo creates an article associated with the product 'A'
    And Mo creates an article associated with the product 'B'
    Then Mo should see an entry for each of the articles created in the sitemap