# frozen_string_literal: true

require "csv"
require_relative "type_converter"

module CsvViewer
  module CsvParser
    module_function

    def parse(csv_file, col_sep: ",", type_converter: TypeConverter)
      @data = CSV.open(
        csv_file,
        headers: true,
        return_headers: false,
        col_sep: col_sep,
        converters: [->(value, field_info) { type_converter.coerce(value, field_info.header) }]
      )
    end
  end
end
