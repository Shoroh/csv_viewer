# frozen_string_literal: true

RSpec.describe CsvViewer::TypeConverter do
  subject(:type_converter) { described_class.coerce(value, type) }

  context "when type is int" do
    let(:type) { "int" }
    let(:value) { "1" }

    it { is_expected.to eq({ value: "1", align: :right }) }
  end

  context "when type is string" do
    let(:type) { "string" }
    let(:value) { "aa bbb cccc" }

    it { is_expected.to eq({ value: "aa\nbbb\ncccc", align: :left }) }
  end

  context "when type is money" do
    let(:type) { "money" }
    let(:value) { "1000000.313" }

    it { is_expected.to eq({ value: "1 000 000,32", align: :right }) }
  end

  context "when type is out of list" do
    let(:type) { "something else" }
    let(:value) { "some value" }

    it { is_expected.to eq({ value: "some value", align: :left }) }
  end
end
