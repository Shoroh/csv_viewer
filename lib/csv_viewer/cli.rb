# frozen_string_literal: true

require_relative "options_parser"

module CsvViewer
  module Cli
    module_function

    def process!(argv_options)
      parsed_options = OptionsParser.parse(argv_options)
      file = argv_options[0]

      raise "Please provide a valid CSV file!" if file.nil? || !File.file?(file)

      App.new(file: file, options: parsed_options).start
    end
  end
end
