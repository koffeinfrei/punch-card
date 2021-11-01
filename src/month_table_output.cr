require "./day_summary"
require "./date_formatter"
require "./table_output"

class MonthTableOutput < TableOutput
  getter day_summary_entries

  def initialize(@day_summary_entries : Array(DaySummaryEntry))
  end

  def render
    date = DateFormatter.new(day_summary_entries.first.day).month_with_name

    output = [] of String
    output << "╭──────────────────╮"
    output << "│ 📅  #{date}     │"

    if day_summary_entries.all?(&.empty?)
      output << render_empty.to_s
    else
      output << render_table.to_s
    end

    output.join("\n")
  end

  private def render_table
    table_data = day_summary_entries.map do |entry|
      [
        DateFormatter.new(entry.day).day_with_name,
        entry.sum_in_hours,
        entry.diff_in_hours,
      ]
    end

    Tablo::Table.new(table_data, connectors: Tablo::CONNECTORS_SINGLE_ROUNDED) do |t|
      t.add_column("Day", width: 16) { |n| n[0] }
      t.add_column("Total hours", width: 16, align_body: Tablo::Justify::Right) { |n| n[1] }
      t.add_column("Diff", width: 16, align_body: Tablo::Justify::Right) { |n| n[2] }
    end
  end
end
