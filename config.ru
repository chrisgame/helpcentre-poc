require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require './lib/helpcentre'

puts 'in config.ru'

class Helpcentre < Sinatra::Base

  configure do
    set :public, "#{Dir.pwd}/public"
    STORE = Store.new
  end

end

run Helpcentre
#Helpcentre.run!