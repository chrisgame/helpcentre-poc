require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require './lib/helpcentre'

puts 'in config.ru'

class Helpcentre < Sinatra::Base

  configure do
    set :port, 51811
    set :public, "#{Dir.pwd}/public"
    STORE = Store.new
  end

end

Helpcentre.run!