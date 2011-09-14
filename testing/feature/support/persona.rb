puts 'Processing persona.rb'

require 'ostruct'
require 'watir-webdriver'

module Helpcentre
  class Persona < OpenStruct

    class << self

      def << instance
        @instances ||= []
        @instances << instance
      end

      def all
        @instances
      end

      def first_names
        @instances.collect { |persona| persona.first_name }
      end
    end

    def initialize &block
      super
      yield self if block_given?
      Persona << self
    end

    def clear_articles
      @product_articles = Hash.new
    end

    def store_article_for product, text
      @product_articles[product] = text
    end

    def product_article_for product
       @product_articles[product]
    end

    def product_article product_name, article
      @product_articles ||= Hash.new
      @product_articles[product_name] = article
    end

    def browser
      @browser ||= Watir::Browser.new :firefox
    end

    def close_browser
      @browser.close if @browser
    end
  end

  Persona.new do |mo|
    mo.first_name = 'Mo'
  end

  Persona.new do |joe|
    joe.first_name = 'Joe'
  end

  Persona.all.each do |persona|
    persona_name = persona.first_name.downcase
    alias_personas_by_first_name= <<-METHOD
      def #{persona_name}
        Persona.all.find{|persona| persona.first_name == '#{persona.first_name}'}
      end
    METHOD
    eval alias_personas_by_first_name
  end
  puts "This test run was brought to you by #{Persona.first_names}"

end

World(Helpcentre)


