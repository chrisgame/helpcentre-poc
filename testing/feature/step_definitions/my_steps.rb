require 'rubygems'
require 'uuid'

Helpcentre::Persona.all.each do |persona|

  Given /^#{persona.first_name} is on the (.*) page$/ do |page_name|
    case page_name
      when 'Create Article'
        persona.browser.goto 'localhost:4567/article/create'
    end
    persona.browser.title.should == page_name
  end

  When /^#{persona.first_name} creates an article associated with the product '(.*)'$/ do |product|
    persona.browser.text_field(:name, 'productName').set 'product'
    persona.store_article_for 'F', 'This is article text for product F. It is unique because of this text '+UUID.generate
    persona.browser.text_field(:name, 'article').set persona.product_article_for(product)
    persona.browser.button(:name, 'add').click
  end

  Then /^#{persona.first_name} should see Mo's article on the site under product '(.*)'$/ do |product|
    persona.browser.goto 'localhost:4567/'
    persona.browser.select_list(:name, 'productName').select product
    persona.browser.button(:name, 'find').click
    persona.browser.element(:id, 'article').text.should == mo.product_article_for(product)
  end

  When /^#{persona.first_name} creates an article that is not associated with anything$/ do
    persona.browser.text_field(:name, 'article').set 'This article text is not attached to anything'
    persona.browser.button(:name, 'add').click
  end

  Then /^#{persona.first_name} should see the message '(.*)' should be displayed$/ do |message_text|
    persona.browser.text.should =~ /#{message_text}/
  end

  Then /^#{persona.first_name} should be able to associate it with product '(.*)'$/ do |product|
    persona.browser.radio(:id, 'otherProductAssociations').select product
  end
end
