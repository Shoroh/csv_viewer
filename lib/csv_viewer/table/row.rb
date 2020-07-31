# frozen_string_literal: true

require_relative "cell"

module CsvViewer
  class Table
    class Row
      attr_accessor :cells

      def initialize(fields)
        @cells = fields.map { |field| Cell.new(value: field[:value], align: field[:align]) }
      end

      def columns_align
        cells.map(&:align)
      end

      def columns_width
        cells.map(&:content_width)
      end

      def height
        cells.map(&:content_height).max
      end

      def lines
        height.times.each_with_object([]) do |index, lines|
          lines << cells.map(&:lines).map { _1[index] }
        end
      end
    end
  end
end
