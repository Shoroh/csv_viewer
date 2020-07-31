# frozen_string_literal: true

require_relative "decorator/design"

module CsvViewer
  class Decorator
    def initialize(table, design: Design::SCHEMAS["ascii"])
      @table = table
      @design = Design::SCHEMAS[design] || Design::SCHEMAS["ascii"]
    end

    def decorate
      output = +""
      output << build_top_separator

      table.rows.each do |row|
        output << build_row(row)
      end

      output << build_bottom_separator

      output
    end

    private

    attr_reader :design, :table

    def build_top_separator
      output = +"%<tl>s"
      output << table.columns_width.each_with_object([]) do |column_width, columns|
        columns << "%<hl>s" * column_width
      end.join("%<tc>s")
      output << "%<tr>s" << "\n"
      output % design
    end

    def build_row(row)
      output = +""
      row.lines.each do |line|
        output << build_line(line) << "\n"
      end
      output << build_middle_separator unless table.last_row?(row)
      output
    end

    def build_line(line)
      output = +"%<vl>s"
      output << table.columns_width.map.with_index do |column_width, index|
        align = table.columns_align[index] == :left ? "-" : nil
        format("%#{align}#{column_width}s", line[index].to_s)
      end.join("%<vl>s")
      output << "%<vl>s"
      output % design
    end

    def build_middle_separator
      output = +"%<lc>s"
      output << table.columns_width.each_with_object([]) do |column_width, columns|
        columns << "%<hl>s" * column_width
      end.join("%<mc>s")
      output << "%<rc>s" << "\n"
      output % design
    end

    def build_bottom_separator
      output = +"%<bl>s"
      output << table.columns_width.each_with_object([]) do |column_width, columns|
        columns << "%<hl>s" * column_width
      end.join("%<bc>s")
      output << "%<br>s" << "\n"
      output % design
    end
  end
end
