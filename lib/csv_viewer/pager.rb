# frozen_string_literal: true

module CsvViewer
  class Pager
    def initialize(csv_instance, rows_per_page: 25)
      @csv = csv_instance
      @rows_per_page = rows_per_page
    end

    def next_rows
      rows = []
      rows << csv.gets until ended? || rows.size == rows_per_page
      rows
    end

    def ended?
      csv.eof?
    end

    private

    attr_reader :csv, :rows_per_page
  end
end
