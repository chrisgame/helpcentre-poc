Feature: The following operations should be available to the editor

Scenario: All articles should have unique references
  Given Mo is on the Create Article page
  When Mo creates an article associated with the product 'F'
  Then Mo should see a unique reference on the screen

Scenario: An editor should be able to create new articles that become visible under the relevant product section on the helpcentre
  Given Mo is on the Create Article page
  When Mo creates an article associated with the product 'F'
  When Mo creates an article associated with the product 'G'
  Then Joe should see Mo's article on the site under product 'F'
  Then Joe should see Mo's article on the site under product 'G'

Scenario: When an editor has created an article and associated it to a product it should appear on the product page
  Given Mo is on the Create Article page
  When Mo creates an article associated with the product 'F'
  When Joe is on the F page
  Then Joe should see Mo's article for product 'F' on the page

Scenario: When more than one article is associated with a product the product should only appear once on the home page
  Given Mo is on the Create Article page
  When Mo creates an article associated with the product 'F'
  When Mo creates an article associated with the product 'F'
  When Joe is on the Home page
  Then Joe should see product 'F' appear once in the dropdown

Scenario: Articles should be able to viewed individually
  Given Mo is on the Create Article page
  When Mo creates an article associated with the product 'F'
  When Joe should be able to see Mo's article for product 'F' under its unique url

Scenario: All articles must be related to at least one product or topic
  Given Mo is on the Create Article page
  When Mo creates an article that is not associated with anything
  Then Mo should see the message 'Articles must be associated with at least one product or topic' should be displayed

#Scenario: Articles can be related to many topics
#  Given Mo is on the Create Article page
#  When Mo creates an article associated with the topic A
#  Then Mo should also be able to associate it with topic B
#  Then Joe should see the article on the site under topic A
#  Then Joe should see the article on the site under topic B

Scenario: Articles can be related to many products
  Given Mo is on the Create Article page
  When Mo creates an article associated with the product 'F'
  Then Mo should be able to associate the article for product 'F' with product 'G'
  Then Joe should see Mo's article on the site under product 'F'
  Then Joe should see Mo's article on the site under product 'G'

#Scenario: Articles can be related to many topics and products
#  Given Mo is on the Create Article page
#  When Mo creates an article associated with the product F
#  Then Mo should also be able to associate it with product G
#  And Mo should also be able to associate it with topic A
#  And Mo should also be able to associate it with topic B
#  Then Joe should see the article on the site under product F
#  Then Joe should see the article on the site under product G
#  Then Joe should see the article on the site under topic A
#  Then Joe should see the article on the site under topic B
#
#Scenario: An editor must have the ability to affect the order that the articles are displayed in
