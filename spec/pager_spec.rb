# frozen_string_literal: true

RSpec.describe CsvViewer::Pager do
  describe "#next_rows" do
    subject(:pager) { described_class.new(csv_instance, rows_per_page: 1) }

    let(:csv_instance) do
      CSV.open("spec/fixtures/test.csv", col_sep: ";")
    end

    it "returns row by row everytime we call it" do
      expect(pager.next_rows).to eq([%w[int string money]])
      expect(pager.next_rows).to eq([["1", "aaa bbb ccc", "1000.33"]])
      expect(pager.next_rows).to eq([["5", "aaaa bbb", "0.001"]])
      expect(pager.next_rows).to eq([["13", "aa bbbb", "10000.00"]])
    end
  end
end
