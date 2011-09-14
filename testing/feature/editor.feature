Feature: The following operations should be available to the editor

Scenario: An editor should be able to create new articles that become visible under the relevant product and problem section on the helpcentre
  Given Mo is on the Create Article page
  When Mo creates an article associated with the product 'F'
  Then Joe should see Mo's article on the site under product 'F'

Scenario: All articles must be related to at least one product or problem
  Given Mo is on the Create Article page
  When Mo creates an article that is not associated with anything
  Then Mo should see the message 'Articles must be associated with at least one product or problem' should be displayed

#Scenario: Articles can be related to many problems
#  Given Mo is on the Create Article page
#  When Mo creates an article associated with the problem A
#  Then Mo should also be able to associate it with problem B
#  Then Joe should see the article on the site under problem A
#  Then Joe should see the article on the site under problem B

Scenario: Articles can be related to many products
  Given Mo is on the Create Article page
  When Mo creates an article associated with the product 'F'
  Then Mo should be able to associate it with product 'G'
  Then Joe should see the article on the site under product 'F'
  Then Joe should see the article on the site under product 'G'

#Scenario: Articles can be related to many problems and products
#  Given Mo is on the Create Article page
#  When Mo creates an article associated with the product F
#  Then Mo should also be able to associate it with product G
#  And Mo should also be able to associate it with problem A
#  And Mo should also be able to associate it with problem B
#  Then Joe should see the article on the site under product F
#  Then Joe should see the article on the site under product G
#  Then Joe should see the article on the site under problem A
#  Then Joe should see the article on the site under problem B
#
#Scenario: An editor must have the ability to affect the order that the articles are displayed in
