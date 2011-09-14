class Store
  def initialize
    @store = Hash.new
  end

  def save id, product_name, text
    @store[id] = {:product => product_name, :text => text}
  end

  def load product_name
    @store.each{|article| article.product == product_name}
  end

  def clear
    @store = Hash.new
  end

  def product_list
    @store.collect{|article| article.product}
  end
end