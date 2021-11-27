require "colorize"

abstract class TableOutput
  COLUMN_WIDTH = 16
  DIFF_STYLER  = ->(cell : Tablo::CellType) do
    color =
      if cell.to_s.starts_with?("-")
        :red
      else
        :green
      end

    cell.colorize(color).to_s
  end

  abstract def empty?
  abstract def header_content
  abstract def render_table
  abstract def render_footer

  def render
    border = "─" * COLUMN_WIDTH

    output = [] of String
    output << "╭─#{border}─╮"
    output << "│ 📅  #{header_content}#{" " * (COLUMN_WIDTH - 4 - header_content.size)} │"
    output << "╰─#{border}─╯"

    if empty?
      output << render_empty.to_s
    else
      output << render_table.to_s
      output << render_footer.to_s
    end

    output.join("\n")
  end

  private def render_empty
    Tablo::Table.new([["No entries"]], connectors: Tablo::CONNECTORS_SINGLE_ROUNDED, header_frequency: nil) do |t|
      t.add_column("", width: 16) { |n| n[0] }
    end
  end
end
