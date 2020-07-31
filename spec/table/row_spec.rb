# frozen_string_literal: true

RSpec.describe CsvViewer::Table::Row do
  subject(:row) { described_class.new(fields) }

  let(:fields) do
    [
      {
        value: "362",
        align: :right
      },
      {
        value: "some string\nanother string",
        align: :left
      },
      {
        value: "1 000 000,31",
        align: :right
      }
    ]
  end

  describe "#cells" do
    subject(:cells) { row.cells }

    it { is_expected.to all(be_a_kind_of(CsvViewer::Table::Cell)) }
  end

  describe "#columns_align" do
    subject(:columns_align) { row.columns_align }

    it { is_expected.to eq(%i[right left right]) }
  end

  describe "#columns_width" do
    subject(:columns_width) { row.columns_width }

    it { is_expected.to eq([3, 14, 12]) }
  end

  describe "#height" do
    subject(:height) { row.height }

    it { is_expected.to eq(2) }
  end

  describe "#lines" do
    subject(:lines) { row.lines }

    it { is_expected.to eq([["362", "some string", "1 000 000,31"], [nil, "another string", nil]]) }
  end
end
