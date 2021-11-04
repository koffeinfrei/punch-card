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
    output << "╰──────────────────╯"

    if day_summary_entries.all?(&.empty?)
      output << render_empty
    else
      output << render_table

      output << render_total
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
      t.add_column("Day", width: COLUMN_WIDTH) { |n| n[0] }
      t.add_column("Total hours", width: COLUMN_WIDTH, align_body: Tablo::Justify::Right) { |n| n[1] }
      t.add_column("Diff", width: COLUMN_WIDTH, align_body: Tablo::Justify::Right) { |n| n[2] }
    end.to_s
  end

  private def render_total
    table_data = [
      ["Total", day_summary_entries.sum(&.sum_in_hours), day_summary_entries.sum(&.diff_in_hours)]
    ]

    Tablo::Table.new(table_data, connectors: Tablo::CONNECTORS_SINGLE_ROUNDED, header_frequency: nil) do |t|
      t.add_column("Total label", width: COLUMN_WIDTH) { |n| n[0] }
      t.add_column("Total hours", width: COLUMN_WIDTH, align_body: Tablo::Justify::Right) { |n| n[1] }
      t.add_column("Total diff", width: COLUMN_WIDTH, align_body: Tablo::Justify::Right) { |n| n[2] }
    end.to_s
  end
end
