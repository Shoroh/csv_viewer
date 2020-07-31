# frozen_string_literal: true

require "optparse"
require "io/console"

module CsvViewer
  module OptionsParser
    class Options
      ROWS_PER_PAGE_DEFAULT = 10
      COL_SEP_DEFAULT = ","
      DESIGN_DEFAULT = "ascii"

      attr_reader :col_sep, :rows_per_page, :design, :memory

      def initialize
        self.col_sep = COL_SEP_DEFAULT
        self.rows_per_page = ROWS_PER_PAGE_DEFAULT
        self.design = DESIGN_DEFAULT
        self.memory = false
      end

      def define_options(parser)
        parser.banner = "Usage: csv_viewer some_csv_file.csv [options]"

        define_parser_options(parser)
        define_page_options(parser)
        define_decorator_options(parser)
        define_debug_options(parser)
        define_common_options(parser)
      end

      private

      attr_writer :col_sep, :page, :rows_per_page, :design, :memory

      def define_page_options(parser)
        parser.separator ""
        parser.separator "Page options:"

        parser.on("-r", "--rows=ROWS", Integer, "Rows per page. #{ROWS_PER_PAGE_DEFAULT} by default.") do |rows|
          self.rows_per_page = rows
        end
      end

      def define_parser_options(parser)
        parser.separator ""
        parser.separator "CSV parsing options:"

        parser.on(
          "-s", "--separator=COL_SEP", String, "CSV column separator, '#{COL_SEP_DEFAULT}' - by default."
        ) do |col_sep|
          self.col_sep = col_sep
        end
      end

      def define_decorator_options(parser)
        parser.separator ""
        parser.separator "Design options:"

        parser.on("-d", "--design=DESIGN", String, "#{DESIGN_DEFAULT} (by default) or UTF") do |design|
          self.design = design.downcase
        end
      end

      def define_debug_options(parser)
        parser.separator ""
        parser.separator "Debug options:"

        parser.on("-m", "--memory", TrueClass, "Show memory usage.") do |mem|
          self.memory = mem
        end
      end

      def define_common_options(parser)
        parser.separator ""
        parser.separator "Common options:"
        parser.on_tail("-h", "--help", "Show this message") do
          puts parser
          exit
        end
        parser.on_tail("--version", "Show version") do
          puts CsvViewer::VERSION
          exit
        end
      end
    end

    module_function

    def parse(args)
      options = Options.new
      OptionParser.new do |parser|
        options.define_options(parser)
        parser.parse!(args)
      end

      options
    end
  end
end
