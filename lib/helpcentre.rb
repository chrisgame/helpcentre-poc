require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'haml'
require './lib/store.rb'
require 'uuid'

class Helpcentre < Sinatra::Base

  get '/' do
    haml :home
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
    haml :articles_for_product, {}, :articles => STORE.load(product_name)
  end

  get '/clear/store' do
    STORE.clear
  end

end