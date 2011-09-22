class Store
  def initialize
    @store = Hash.new
  end

  def save id, product_name, text
    @store[id] = {:product => product_name, :text => text}
  end

  def load product_name
    @store.each_value.collect do  |article|
      if (article[:product] == product_name) then
        article[:text]
      end
    end
  end

  def clear
    @store = Hash.new
  end

  def product_list
    @store.each_value.collect {|article| article[:product]}
  end
end