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
    persona.browser.text_field(:name, 'productName').set product
    persona.store_article_for product, "This is article text for #{product}. It is unique because of this text "+UUID.generate
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

  Then /^#{persona.first_name} should be able to associate the article for product '(.*)' with product '(.*)'$/ do |existing_product_article, new_product|
    persona.browser.refresh
    begin
      persona.browser.checkbox(:value, product).set(true)
    rescue
      persona.browser.text_field(:name, 'productName').set new_product
      persona.store_article_for new_product, persona.product_article_for(existing_product_article)
      persona.browser.text_field(:name, 'article').set persona.product_article_for(existing_product_article)
    end
    persona.browser.button(:name, 'add').click
  end
end
