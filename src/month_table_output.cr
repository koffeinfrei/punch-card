require "./day_summary"
require "./date_formatter"

class MonthTableOutput
  getter day_summary_entries

  def initialize(@day_summary_entries : Array(DaySummaryEntry))
  end

  def render
    table_data = day_summary_entries.map do |entry|
      [
        DateFormatter.new(entry.day).day_with_name,
        entry.sum_in_hours,
        entry.diff_in_hours,
      ]
    end

    table = Tablo::Table.new(table_data, connectors: Tablo::CONNECTORS_SINGLE_ROUNDED) do |t|
      t.add_column("Day", width: 16) { |n| n[0] }
      t.add_column("Total hours", width: 16, align_body: Tablo::Justify::Right) { |n| n[1] }
      t.add_column("Diff", width: 16, align_body: Tablo::Justify::Right) { |n| n[2] }
    end

    date = DateFormatter.new(day_summary_entries.first.day).month_with_name
    puts "╭──────────────────╮"
    puts "│ 📅  #{date}     │"
    puts table
  end
end
