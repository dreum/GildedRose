require './gilded_rose'
require "rspec"

def notASpecialItem(item)
	item.name != "Aged Brie" && item.name != "Backstage passes to a TAFKAL80ETC concert" && item.name !="Sulfuras, Hand of Ragnaros" 
end

def reduceQualityBySell_InTimeAndGetChangeInQuality(item)
	initialQuality = item.quality
	item.sell_in.times {subject.update_quality}
	changeInQuality =  initialQuality - item.quality
end

def updateQualityOnceAndGetChangeInQuality(item)
	initialQuality = item.quality
	subject.update_quality
	changeInQuality =  initialQuality - item.quality
end

describe GildedRose, "#Aged Brie" do
	before(:each) do
		@AgedBrieItem = subject.items[1]
	end

	it "should never have quality above 50" do
		50.times { subject.update_quality }
		@AgedBrieItem.quality.should eq(50)
	end

	it "should have it's quality go up over time" do
		expectedNegativeChangeInQuality = -@AgedBrieItem.sell_in
		changeInQuality = reduceQualityBySell_InTimeAndGetChangeInQuality(@AgedBrieItem)
		changeInQuality.should eq(expectedNegativeChangeInQuality)
	end

	it "should have it's quality go up double after sell in time" do
		@AgedBrieItem.sell_in.times { subject.update_quality }
		changeInQuality = updateQualityOnceAndGetChangeInQuality(@AgedBrieItem)
		changeInQuality.should eq(-2)
	end
end

describe GildedRose, "# Dexterity Vest" do
	before(:each) do
		@DexterityItem = subject.items[0]
	end

	it "should have quality go down one per sell_in time" do
		expectedChangeInQuality = @DexterityItem.sell_in
		changeInQuality = reduceQualityBySell_InTimeAndGetChangeInQuality(@DexterityItem) 
		changeInQuality.should eq(expectedChangeInQuality)
	end

	it "should have quality go down by two after sell_in time" do
		@DexterityItem.sell_in.times { subject.update_quality }
		changeInQuality = updateQualityOnceAndGetChangeInQuality(@DexterityItem)
		changeInQuality.should eq(2)
	end
end

describe GildedRose, "# Elixir of the Mongoose" do
	before(:each) do
		@ElixirItem = subject.items[2]
	end
	it "should have quality go down one per sell_in time" do
		expectedChangeInQuality = @ElixirItem.sell_in
		changeInQuality = reduceQualityBySell_InTimeAndGetChangeInQuality(@ElixirItem) 
		changeInQuality.should eq(expectedChangeInQuality)
	end

	it "should have quality go down by two after sell_in time" do
		@ElixirItem.sell_in.times { subject.update_quality }
		changeInQuality = updateQualityOnceAndGetChangeInQuality(@ElixirItem)
		changeInQuality.should eq(2)
	end
end

describe GildedRose, "# Sulfuras, Hand of Ragnaros" do
	before(:each) do
		@SulfurasItem = subject.items[3]
	end
	it "should have it's quality never go down" do
		initialQuality = @SulfurasItem.quality
		50.times {subject.update_quality}
		@SulfurasItem.quality.should eq(initialQuality)
	end

	it "should have it's sell in time never go down" do
		initialSellIn = @SulfurasItem.sell_in
		50.times {subject.update_quality}
		@SulfurasItem.sell_in.should eq(initialSellIn)
	end
end

describe GildedRose, "# Backstage passes to a TAFKAL80ETC concert" do
	before(:each) do
		@BackstagePassesItem = subject.items[4]
	end
	it "should have it's quality go up by one initially" do
		initialQuality = @BackstagePassesItem.quality
		1.times {subject.update_quality}
		@BackstagePassesItem.quality.should eq(initialQuality + 1)
	end

	it "should have it's quality go up by two 10 days before the concert" do
		(@BackstagePassesItem.sell_in - 10).times {subject.update_quality}
		initialQuality = @BackstagePassesItem.quality
		subject.update_quality
		@BackstagePassesItem.quality.should eq(initialQuality + 2)
	end
	it "should have it's quality go up by three 5 days before the concert" do
		(@BackstagePassesItem.sell_in - 5).times {subject.update_quality}
		initialQuality = @BackstagePassesItem.quality
		subject.update_quality
		@BackstagePassesItem.quality.should eq(initialQuality + 3)
	end

	it "should have it's quality be zero after the concert" do
		(@BackstagePassesItem.sell_in + 1).times {subject.update_quality}
		@BackstagePassesItem.quality.should eq(0)
	end
end

describe GildedRose, "# Conjured Mana Cake" do
	before(:each) do
		@ConjuredManaCake = subject.items[5]
	end
	it "should have quality go down two per sell_in time" do
		expectedChangeInQuality = @ConjuredManaCake.sell_in * 2
		changeInQuality = reduceQualityBySell_InTimeAndGetChangeInQuality(@ConjuredManaCake) 
		changeInQuality.should eq(expectedChangeInQuality)
	end

	it "should have quality go down 4 after sell_in time" do
		@ConjuredManaCake.sell_in.times {subject.update_quality}
		initialQuality = @ConjuredManaCake.quality
		subject.update_quality
		changeInQuality = initialQuality - @ConjuredManaCake.quality
		changeInQuality.should eq(4)
	end
end