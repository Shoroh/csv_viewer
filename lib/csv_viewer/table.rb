# frozen_string_literal: true

require_relative "table/row"

module CsvViewer
  class Table
    attr_reader :rows, :columns_width, :columns_align

    def initialize
      @rows = []
      @columns_width = []
      @columns_align = []
    end

    def rows=(rows)
      @rows = rows.map { Row.new(_1.fields) }
      define_columns_align
      define_columns_width
    end

    def last_row?(row)
      rows.last == row
    end

    private

    def define_columns_align
      @columns_align = rows.first.columns_align
    end

    def define_columns_width
      columns_width.clear

      rows.each do |row|
        row.columns_width.each_with_index do |column_width, index|
          columns_width[index] ||= 0
          next unless columns_width[index] < column_width

          columns_width[index] = column_width
        end
      end
    end
  end
end
