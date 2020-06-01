require "test_helper"
require "minitest/benchmark"

if ENV['BENCH']
  class BenchRangeCompacter < Minitest::Benchmark
    def self.bench_range
      Minitest::Benchmark.bench_exp(1, 1000)
    end

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

    def bench_range_compacter
      ranges = 1000.times.map do |i|
        range = if i > 100
                  i.even? ? 1..40 : 60..90
                else
                  i.even? ? 1..50 : 51..100
                end
        Item.new i, range
      end
      assert_performance_exponential 0.9 do |n|
        RangeCompacter::Compacter.new(*ranges[0..n]).compact(1..100)
      end
    end
  end
end
