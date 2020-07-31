# frozen_string_literal: true

require "csv_viewer/version"

require "csv_viewer/pager"
require "csv_viewer/table"
require "csv_viewer/csv_parser"
require "csv_viewer/cli"
require "csv_viewer/decorator"
require "get_process_mem"

module CsvViewer
  class Error < StandardError; end

  class App
    # rubocop:disable Metrics/ParameterLists
    def initialize(
      file:,
      options:,
      parser: CsvParser,
      pager_class: Pager,
      table_class: Table,
      decorator_class: Decorator
    )
      csv_data = parser.parse(file, col_sep: options.col_sep)
      @pager = pager_class.new(csv_data, rows_per_page: options.rows_per_page)
      @table = table_class.new
      @decorator = decorator_class.new(@table, design: options.design)
      @options = options
      @mem = GetProcessMem.new
    end
    # rubocop:enable Metrics/ParameterLists

    def start
      until pager.ended?
        table.rows = pager.next_rows
        puts decorator.decorate

        wait_for_user_input
      end
    end

    private

    attr_reader :pager, :decorator, :table, :options, :mem

    def wait_for_user_input
      options.memory ? puts(memory_usage) : puts
      puts "Any key for the next page, Q - to exit..."
      puts
      state = `stty -g`
      `stty raw -echo -icanon isig`

      exit if /q/i.match?(STDIN.getc.chr)
    ensure
      `stty #{state}`
    end

    def memory_usage
      "Memory used : #{mem.mb.round(0)}MB"
    end
  end
end
