class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      item.update
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
    @quality = 80 if name == "Sulfuras, Hand of Ragnaros"
  end

  def update
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end

class Normal < Item
  def update
    @sell_in -= 1
    return if @quality == 0
    @quality -= 1
    @quality -= 1 if @sell_in < 0 && @quality > 0
  end
end

class AgedBrie < Item
  def update
    @sell_in -= 1
    return if @quality == 50
    @quality += 1
  end
end

class Backstage < Item
  def update
    @sell_in -= 1

    return if @quality == 0 && @sell_in < 0
    @quality += 1
    @quality += 1 if @sell_in < 10
    @quality += 1 if @sell_in < 5

    @quality = 50 if @quality > 50
    @quality = 0  if @sell_in < 0 || @quality < 0
  end
end

class Conjured < Item
  def update
    @sell_in -= 1
    return @quality -= 2 if @quality > 2
    @quality = 0
  end
end
