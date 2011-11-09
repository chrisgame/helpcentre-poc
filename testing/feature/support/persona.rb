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

    def product_articles
      @product_articles
    end

    def product_article_text_for product
      @product_articles.select{|uuid, article| article[:product_name] == product}.each_value.collect{|value| value[:text]}
    end

    def load_article uuid
      @product_articles.select{|k,v| k == uuid}
    end

    def store_product_article uuid, product_name, text
      @product_articles ||= Hash.new
      @product_articles[uuid] = {:text => text, :product_name => product_name}
    end

    def article_for_product product_name
      @product_articles.select {|uuid, article| article[:product_name] == product_name}
    end

    def browser
      @browser ||= Watir::Browser.new :firefox
    end

    def close_browser
      if @browser
        @browser.close
        @browser = nil
      end
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


