class Item

  attr_accessor :name, :sell_in, :quality
        
  def initialize (name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end


end

def reduceQualityByOne(item)
	changeQuality(item, -1)
end

def increaseQualityByOne(item)
	changeQuality(item, 1)
end

def changeQuality(item, num)
	if (item.quality < 50)
		item.quality = item.quality + num
	end
end