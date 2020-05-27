require "range_compacter/version"

module RangeCompacter
  class Error < StandardError; end

  class Compacter
    def initialize(*items)
      @items = items
    end

    # Main logic
    def compact(target_range)
      used = []

      items_in_range = @items.select do |item|
        item.cover?(target_range.begin) || target_range.cover?(item.begin)
      end.sort_by(&:begin)

      items_in_range.each_with_object([]) do |item, result|
        next if used.include? item

        if item.begin <= target_range.begin && item.end >= target_range.end
          result << item
          used << item
        else
          item_to_compact = items_in_range.find do |i|
            item.end <= i.begin && !used.include?(i)
          end
          if item_to_compact
            result << [item, item_to_compact]
            used << item_to_compact
          else
            result << item
          end
          used << item
        end
        result
      end
    end
  end
end
