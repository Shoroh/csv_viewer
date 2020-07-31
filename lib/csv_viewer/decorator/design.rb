# frozen_string_literal: true

module CsvViewer
  class Decorator
    module Design
      SCHEMAS = {
        "ascii" => {
          tl: "+",
          tr: "+",
          bl: "+",
          br: "+",
          mc: "+",
          tc: "-",
          lc: "|",
          rc: "|",
          bc: "+",
          hl: "-",
          vl: "|"
        }.freeze,

        "utf" => {
          # top left:
          tl: "┌",
          # top right:
          tr: "┐",
          # bottom left:
          bl: "└",
          # bottom right:
          br: "┘",
          # middle cross:
          mc: "┼",
          # top cross:
          tc: "┬",
          # left cross:
          lc: "├",
          # right cross:
          rc: "┤",
          # bottom cross:
          bc: "┴",
          # horizontal line:
          hl: "─",
          # vertical line:
          vl: "│"
        }
      }.freeze
    end
  end
end
