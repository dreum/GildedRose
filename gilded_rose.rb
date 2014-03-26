require './item.rb'

class GildedRose

	attr_accessor :items
	@items = []

	def initialize
		@items = []
		@items << Item.new("+5 Dexterity Vest", 10, 20)
		@items << Item.new("Aged Brie", 2, 0)
		@items << Item.new("Elixir of the Mongoose", 5, 7)
		@items << Item.new("Sulfuras, Hand of Ragnaros", 0, 80)
		@items << Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20)
		@items << Item.new("Conjured Mana Cake", 3, 6)
	end

	def update_quality

		@items.each do |item|
			if (item.name != "Sulfuras, Hand of Ragnaros")
				item.sell_in = item.sell_in - 1;
			end

			case 
			when item.name == "Aged Brie"
				increaseQualityByOne(item)
				if (item.sell_in < 0)
					increaseQualityByOne(item)
				end
			when item.name == "Backstage passes to a TAFKAL80ETC concert"
				case item.sell_in 
				when 5...10
					changeQuality(item, 2)
				when 0...5
					changeQuality(item, 3)
				when -Float::INFINITY...0
					item.quality = 0
				else
					increaseQualityByOne(item)
				end
			when item.name == "Conjured Mana Cake"
				changeQuality(item, -2)
				if (item.sell_in < 0)
					changeQuality(item, -2)
				end
			when item.name != "Sulfuras, Hand of Ragnaros"
				reduceQualityByOne(item)
				if (item.sell_in < 0)
					reduceQualityByOne(item)
				end
			end
		end
	end
end
