require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'haml'
require './lib/store.rb'
require 'uuid'
require 'builder'
require 'json'

class Helpcentre < Sinatra::Base

  get '/clear/store' do
    STORE.clear
  end

  get '/sitemap.xml' do
    builder :sitemap, {}, :urls => STORE.relative_article_urls
  end

  get '/' do
    haml :home, {}, :articles => STORE.product_list
  end

  get '/article/create' do
    haml :create_article, {}, :articles => STORE.product_list
  end

  get '/article/store' do
    article_id = UUID.generate

    STORE.save article_id, params['productName'], params['text']

    article_id
  end

  get '/:product_name' do |product_name|
    haml :articles_for_product, {}, :articles => STORE.load_article_text(product_name), :product_name => product_name
  end

  get '/:product_name/json' do |product_name|
    content_type :json
    STORE.load_all_for_product(product_name).to_json
  end

  get '/:product_name/:uuid' do |product_name, uuid|
    haml :article, {}, :article => STORE.load_article(uuid), :product_name => product_name
  end

end