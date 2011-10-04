Feature: The following scenarios should be possible for the benefits of search engines

  Scenario: All articles should appear in the sitemap.xml
    Given Mo is on the Create Article page
    When Mo creates an article associated with the product 'A'
    And Mo creates an article associated with the product 'B'
    And Mo creates an article associated with the product 'C'
    Then Mo should see an entry for each of the articles created in the sitemap

