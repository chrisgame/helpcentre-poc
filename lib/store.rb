class Store
  def initialize
    @store = Hash.new
  end

  def save id, product_name, text
    @store[id] = {:product => product_name, :text => text}
  end

  def load_all
    @store
  end

  def load_all_for_product product_name
    @store.select{|k,v| v[:product] == product_name}
  end

  def load_article_text product_name
    @store.each_value.collect do |article|
      if (article[:product] == product_name) then
        article[:text]
      end
    end.compact
  end

  def load_article uuid
    @store.select{|k,v| k == uuid}
  end

  def clear
    @store = Hash.new
  end

  def product_list
    @store.each_value.collect{|article| article[:product]}.uniq
  end

  def relative_article_urls
    @store.each.collect{|uuid, article| "#{article[:product]}/#{uuid}"}.uniq
  end
end