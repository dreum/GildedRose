class Item

  attr_accessor :name, :sell_in, :quality
        
  def initialize (name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def reduceSellIn
    @sell_in = @sell_in - 1;
  end

  def updateQuality
    reduceQualityByOne
      if (@sell_in < 0)
        reduceQualityByOne
      end
  end
  
  def reduceQualityByOne
  	changeQuality(-1)
  end

  def increaseQualityByOne
  	changeQuality(1)
  end

  def changeQuality(num)
  	if (@quality < 50)
  		@quality = @quality + num
  	end
  end
end

class AgedBrieItem < Item

  def  updateQuality
    increaseQualityByOne
    if (@sell_in < 0)
      increaseQualityByOne
    end
  end
end

class SulfurasItem < Item

  def reduceSellIn
  end

  def updateQuality
  end
end

class BackstagePassesItem < Item

  def  updateQuality
    case @sell_in 
    when 5...10
      changeQuality(2)
    when 0...5
      changeQuality(3)
    when -Float::INFINITY...0
      @quality = 0
    else
      increaseQualityByOne
    end
  end
end

class ConjuredItem < Item

  def  updateQuality
    changeQuality(-2)
    if (@sell_in < 0)
      changeQuality(-2)
    end
  end
end
