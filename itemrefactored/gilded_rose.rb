require './item.rb'

class GildedRose

	attr_accessor :items
	@items = []

	def initialize
		@items = []
		@items << Item.new("+5 Dexterity Vest", 10, 20)
		@items << AgedBrieItem.new("Aged Brie", 2, 0)
		@items << Item.new("Elixir of the Mongoose", 5, 7)
		@items << SulfurasItem.new("Sulfuras, Hand of Ragnaros", 0, 80)
		@items << BackstagePassesItem.new("Backstage passes to a TAFKAL80ETC concert", 15, 20)
		@items << ConjuredItem.new("Conjured Mana Cake", 3, 6)
	end

	def update_quality

		@items.each do |item|
			item.reduceSellIn

			item.updateQuality
		end
	end
end
