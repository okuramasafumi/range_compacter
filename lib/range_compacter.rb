require "range_compacter/version"

module RangeCompacter
  class Error < StandardError; end

  class Compacter
    def initialize(*items)
      @items = items
    end

    # Main logic
    def compact(target_range)
      result = []

      target_items = @items.select do |item|
        item.cover?(target_range.begin) || target_range.cover?(item.begin)
      end.sort_by(&:begin)

      target_items.each_with_index do |item, idx|
        next if result.flatten.include?(item)

        if item.begin <= target_range.begin && item.end >= target_range.end
          result << item
        else
          item_to_compact = target_items[idx..].bsearch do |i|
            item.end <= i.begin && !result.flatten.include?(i)
          end
          if item_to_compact
            result << [item, item_to_compact]
          else
            result << item
          end
        end
      end
      result
    end
  end
end
