# frozen_string_literal: true

module CsvViewer
  module TypeConverter
    ALIGN_LEFT = :left
    ALIGN_RIGHT = :right

    module_function

    # rubocop:disable Metrics/MethodLength
    def coerce(value, type)
      case type
      when "int"
        { value: value, align: ALIGN_RIGHT }
      when "string"
        { value: value.tr(" ", "\n"), align: ALIGN_LEFT }
      when "money"
        formatted_value = format("%<float>.2f", float: value.to_f.ceil(2))
                          .tr(".", ",")
                          .reverse
                          .gsub(/(\d{3})(?=\d)/, '\\1 ')
                          .reverse
        { value: formatted_value, align: ALIGN_RIGHT }
      else
        { value: value, align: ALIGN_LEFT }
      end
    end
    # rubocop:enable Metrics/MethodLength
  end
end
