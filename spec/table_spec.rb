# frozen_string_literal: true

RSpec.describe CsvViewer::Table do
  subject(:table) { described_class.new }

  describe "#rows=" do
    it "replaces the current rows set and recalculates the columns width and alignments" do
      expect(table.rows).to be_empty

      expect(table.columns_align).to be_empty
      expect(table.columns_width).to be_empty

      table.rows = [
        instance_double(
          CSV::Row, fields: [
            { value: "1", align: :right },
            { value: "aa\nbbb", align: :left },
            { value: "1 000,31", align: :right }
          ]
        )
      ]

      expect(table.rows).to all(be_an_instance_of(CsvViewer::Table::Row))
      expect(table.rows.first.lines).to eq([["1", "aa", "1 000,31"], [nil, "bbb", nil]])
      expect(table.columns_align).to eq(%i[right left right])
      expect(table.columns_width).to eq([1, 3, 8])

      table.rows = [
        instance_double(
          CSV::Row, fields: [
            { value: "2", align: :left },
            { value: "bb", align: :left },
            { value: "362", align: :right }
          ]
        )
      ]

      expect(table.rows).to all(be_an_instance_of(CsvViewer::Table::Row))
      expect(table.rows.first.lines).to eq([%w[2 bb 362]])
      expect(table.columns_align).to eq(%i[left left right])
      expect(table.columns_width).to eq([1, 2, 3])
    end
  end
end
