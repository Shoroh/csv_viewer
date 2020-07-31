# frozen_string_literal: true

RSpec.describe CsvViewer::Table::Cell do
  subject(:cell) { described_class.new(**params) }

  let(:params) do
    {
      value: "some string\nanother string",
      align: :right
    }
  end

  describe "#lines" do
    subject(:lines) { cell.lines }

    it { is_expected.to eq(["some string", "another string"]) }
  end

  describe "#align" do
    subject(:align) { cell.align }

    it { is_expected.to eq(:right) }
  end

  describe "#content_width" do
    subject(:content_width) { cell.content_width }

    it { is_expected.to eq(14) }
  end

  describe "#content_height" do
    subject(:content_height) { cell.content_height }

    it { is_expected.to eq(2) }
  end
end
