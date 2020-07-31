# frozen_string_literal: true

RSpec.describe CsvViewer::Cli do
  describe ".process!" do
    subject(:cli) { described_class }

    let(:parsed_options) { instance_double(CsvViewer::OptionsParser::Options) }
    let(:app) { instance_double(CsvViewer::App) }

    before do
      allow(CsvViewer::OptionsParser).to receive(:parse).with([file]).and_return(parsed_options)
      allow(CsvViewer::App).to receive(:new).with(file: file, options: parsed_options).and_return(app)
      allow(app).to receive(:start)
    end

    context "when file is a valid CSV file" do
      let(:file) { "spec/fixtures/test.csv" }

      it "calls OptionsParser to parse CLI arguments" do
        cli.process!([file])
        expect(CsvViewer::OptionsParser).to have_received(:parse).with([file])
      end

      it "calls App with new and start" do
        cli.process!([file])
        expect(CsvViewer::App).to have_received(:new).with(file: file, options: parsed_options)
        expect(app).to have_received(:start)
      end
    end

    context "when file doesn't exist" do
      let(:file) { "some_text" }

      it "doesn't call App with new and start but raises an Error instead" do
        expect { cli.process!([file]) }.to raise_error("Please provide a valid CSV file!")
      end
    end
  end
end
