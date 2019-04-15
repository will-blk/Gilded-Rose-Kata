require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Normal.new("Normal", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq("Normal")
    end

    it "lower both values for item" do
      items = [Normal.new("Normal", 10, 8)]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq(9)
      expect(items[0].quality).to eq(7)
    end

    it "degrades items quality faster after sell date" do
      items = [Normal.new("Normal", 0, 8)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq(6)
    end

    it "does not degrades quality lower than 0" do
      items = [Normal.new("Normal", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq(0)
    end

    it "increases 'Aged Brie' quality after each day" do
      items = [AgedBrie.new("Aged Brie", 5, 3)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq(4)
    end

    context "not increases a quality passes 50" do
      it "does not increases 'Aged Brie' quality passes 50" do
        items = [AgedBrie.new("Aged Brie", 5, 50)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq(50)
      end

      it "does not increases 'Backstage' quality passes 50" do
        items = [Backstage.new("Backstage passes to a TAFKAL80ETC concert", 5, 50)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq(50)
      end
    end
    it "does not change 'Sulfuras' items" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 6, 80)]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq(6)
      expect(items[0].quality).to eq(80)
    end

    it "check 'Sulfuras' item quality is 80" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 6, 7)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq(80)
    end

    it "increases 'Backstage passes' quality by 2 when there are 10 days or less" do
      items = [Backstage.new("Backstage passes to a TAFKAL80ETC concert", 10, 6)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq(8)
    end

    it "increases 'Backstage passes' quality by 3 when there are 5 days or less" do
      items = [Backstage.new("Backstage passes to a TAFKAL80ETC concert", 5, 6)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq(9)
    end

    it "drops 'Backstage passes' quality to 0 after passes selling date" do
      items = [Backstage.new("Backstage passes to a TAFKAL80ETC concert", 0, 6)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq(0)
    end

    it "decreases 'Conjured' quality twice as fast as normal items" do
      items = [Conjured.new("Conjured", 5, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq(8)
    end

  end

end
