# frozen_string_literal: true

RSpec.describe CsvViewer::Decorator do
  describe ".decorate" do
    subject(:decorate) { described_class.new(table).decorate }

    let(:table) do
      instance_double(
        CsvViewer::Table,
        last_row?: ->(row) { row[1] == "aaa" },
        columns_width: [2, 4, 3],
        columns_align: %i[right left right],
        rows: [
          instance_double(
            CsvViewer::Table::Row, lines: [
              %w[1 aaa 350], [nil, "bbbb", nil], [nil, "aaa", nil]
            ]
          )
        ]
      )
    end

    it "returns an expected ASCII table" do
      expect(decorate).to eq("+-----------+\n| 1|aaa |350|\n|  |bbbb|   |\n|  |aaa |   |\n+--+----+---+\n")
    end
  end
end
