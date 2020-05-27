require "test_helper"

class RangeCompacterTest < Minitest::Test
  class Item
    def initialize(id, range)
      @id = id
      @range = range
    end

    def begin
      @range.begin
    end

    def end
    @range.end
    end

    def cover?(it)
      @range.cover?(it)
    end
  end

  def test_that_it_has_a_version_number
    refute_nil ::RangeCompacter::VERSION
  end

  def test_with_ranges
    item1 = 1..100
    item2 = 20..40
    item3 = 60..120
    item4 = 100..200
    compacter = RangeCompacter::Compacter.new(item1, item2, item3, item4)
    assert_equal [item1, [item2, item3]], compacter.compact(30..70)
  end

  def test_with_items
    item1 = Item.new 1, 1..100
    item2 = Item.new 2, 20..40
    item3 = Item.new 3, 60..120
    item4 = Item.new 4, 100..200
    compacter = RangeCompacter::Compacter.new(item1, item2, item3, item4)
    assert_equal [item1, [item2, item3]], compacter.compact(30..70)
    assert_equal 2, compacter.compact(30..70).size
  end

  def test_more_complex
    item1 = Item.new 1, Time.new(2020, 4, 1, 11, 0, 0)..Time.new(2020, 4, 1, 14, 0, 0)
    item2 = Item.new 2, Time.new(2020, 4, 1, 11, 0, 0)..Time.new(2020, 4, 1, 12, 30, 0)
    item3 = Item.new 3, Time.new(2020, 4, 1, 12, 30, 0)..Time.new(2020, 4, 1, 14, 0, 0)
    item4 = Item.new 4, Time.new(2020, 4, 1, 12, 0, 0)..Time.new(2020, 4, 1, 13, 30, 0)
    compacter = RangeCompacter::Compacter.new(item1, item2, item3, item4)
    assert_equal [item1, [item2, item3], item4], compacter.compact(Time.new(2020, 4, 1, 12, 0, 0)..Time.new(2020, 4, 1, 13, 0, 0))
  end

  def test_many_data
    item1 = Item.new 1, Time.new(2020, 4, 1, 11, 0, 0)..Time.new(2020, 4, 1, 14, 0, 0)
    item2 = Item.new 2, Time.new(2020, 4, 1, 11, 0, 0)..Time.new(2020, 4, 1, 12, 30, 0)
    item3 = Item.new 3, Time.new(2020, 4, 1, 12, 30, 0)..Time.new(2020, 4, 1, 14, 0, 0)
    item4 = Item.new 4, Time.new(2020, 4, 1, 12, 0, 0)..Time.new(2020, 4, 1, 13, 30, 0)
    item5 = Item.new 5, Time.new(2020, 4, 1, 11, 10, 0)..Time.new(2020, 4, 1, 12, 20, 0)
    item6 = Item.new 6, Time.new(2020, 4, 1, 11, 0, 0)..Time.new(2020, 4, 1, 12, 30, 0)
    item7 = Item.new 7, Time.new(2020, 4, 1, 12, 30, 0)..Time.new(2020, 4, 1, 14, 0, 0)
    item8 = Item.new 8, Time.new(2020, 4, 1, 12, 30, 0)..Time.new(2020, 4, 1, 14, 0, 0)
    compacter = RangeCompacter::Compacter.new(item1, item2, item3, item4, item5, item6, item7, item8)
    assert_equal [item1, [item2, item3], [item6, item7], [item5, item8], item4], compacter.compact(Time.new(2020, 4, 1, 12, 0, 0)..Time.new(2020, 4, 1, 13, 0, 0))
  end
end
