# frozen_string_literal: true

module CsvViewer
  class Table
    class Cell
      attr_reader :lines, :align

      def initialize(value:, align:)
        @align = align
        @lines = value.to_s.split("\n")
      end

      def content_width
        lines.map(&:size).max
      end

      def content_height
        lines.size
      end
    end
  end
end
