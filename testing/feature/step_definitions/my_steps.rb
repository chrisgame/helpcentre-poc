require 'rubygems'
require 'uuid'
require 'nokogiri'

Helpcentre::Persona.all.each do |persona|

  Given /^#{persona.first_name} is on the (.*) page$/ do |page_name|
    case page_name
      when 'Home'
        persona.browser.goto 'localhost:4567/'
        persona.browser.title.should == page_name
      when 'Create Article'
        persona.browser.goto 'localhost:4567/article/create'
        persona.browser.title.should == page_name
      else
        persona.browser.goto "localhost:4567/#{page_name}"
        persona.browser.title.should == "Articles for #{page_name}"
    end

  end

  When /^#{persona.first_name} creates an article associated with the product '(.*)'$/ do |product|
    persona.browser.text_field(:name, 'productName').set product
    article_text = "This article text is unique because of this text "+UUID.generate
    persona.browser.text_field(:name, 'article').set article_text
    persona.browser.button(:name, 'add').click
    persona.store_product_article persona.browser.element(:id, 'uniqueId').text ,product, article_text
  end

  Then /^#{persona.first_name} should see Mo's article on the site under product '(.*)'$/ do |product|
    persona.browser.goto 'localhost:4567/'
    persona.browser.select_list(:name, 'productName').select product
    persona.browser.button(:name, 'find').click
    articleListArray= []

    persona.browser.ul(:id, 'articleList').lis.each{|li| articleListArray << li.text}

    articleListArray.should =~ mo.product_article_text_for(product)
  end

  Then /^#{persona.first_name} should see Mo's article for product '(.*)' on the page$/ do |product|
    articleListArray= []

    persona.browser.ul(:id, 'articleList').lis.each{|li| articleListArray << li.text}

    articleListArray.should =~ mo.product_article_text_for(product)
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
      persona.browser.checkbox(:value, new_product).set(true)
    rescue
      persona.browser.text_field(:name, 'productName').set new_product
      persona.browser.text_field(:name, 'article').set persona.product_article_text_for existing_product_article
    end
    persona.browser.button(:name, 'add').click
    persona.store_product_article persona.browser.element(:id, 'uniqueId').text, new_product, persona.product_article_text_for(existing_product_article)[0]
  end

  Then /^#{persona.first_name} should not see an entry for each of the products created in the sitemap$/ do
    persona.product_articles.each do |uuid, article|
      sitemap_entry_for(article[:product_name]).should == false
    end
  end

  Then /^#{persona.first_name} should see an entry for each of the articles created in the sitemap$/ do
    persona.product_articles.each do |uuid, article|
      sitemap_entry_for(article[:product_name], uuid).should_not == false
    end
  end

  Then /^#{persona.first_name} should see product '(.*)' appear once in the dropdown$/ do  |product_name|
    options = persona.browser.element(:name, 'productName').options.collect{|value| value.text}
    options.size.should == 1
    options[0].should == product_name
  end

  When /^#{persona.first_name} should be able to see Mo's article for product '(.*)' under its unique url$/ do |product_name|
    article = mo.article_for_product(product_name)
    persona.browser.goto "http://localhost:4567/#{product_name}/#{article.keys[0]}"
    persona.browser.text.should =~ /#{article.values[0][:text]}/
  end

  Then /^#{persona.first_name} should see a unique reference on the screen$/ do
    persona.browser.element(:id, 'uniqueId').text.should_not == ''
  end
end


def sitemap_entry_for product_name, uuid = nil
    uri = URI.parse 'http://localhost:4567'
    http = Net::HTTP.new(uri.host, uri.port)

    request = Net::HTTP::Get.new('/sitemap.xml')
    response = http.request(request).body
    puts response
    doc = Nokogiri::XML(response)

    if uuid then
      doc.xpath("//urlset/url/loc/text()= 'http://cold-journey-9363.heroku.com/#{product_name}/#{uuid}'")
    else
      doc.xpath("//urlset/url/loc/text()= 'http://cold-journey-9363.heroku.com/#{product_name}$'")
    end

end