# frozen_string_literal: true

RSpec.describe CsvViewer::CsvParser do
  describe ".parse" do
    subject(:parser) { described_class }

    let(:file) { File.open("spec/fixtures/test.csv") }
    let(:converter) { double(CsvViewer::TypeConverter) }
    let(:params) do
      {
        col_sep: ",",
        type_converter: converter
      }
    end

    it "calls CSV with open method" do
      allow(CSV).to receive(:open).once
      parser.parse(file, **params)
      expect(CSV).to have_received(:open).once
    end

    it "returns CSV instance" do
      expect(parser.parse(file, **params)).to be_an_instance_of(CSV)
    end
  end
end
