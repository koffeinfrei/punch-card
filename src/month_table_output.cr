require "./day_summary"
require "./date_formatter"
require "./number_formatter"
require "./table_output"

class MonthTableOutput < TableOutput
  getter day_summary_entries

  def initialize(@day_summary_entries : Array(DaySummaryEntry))
  end

  def empty?
    day_summary_entries.all?(&.empty?)
  end

  def header_content
    DateFormatter.new(day_summary_entries.first.day).month_with_name
  end

  def render_table
    table_data = day_summary_entries.map do |entry|
      [
        DateFormatter.new(entry.day).day_with_name,
        NumberFormatter.new(entry.sum_in_hours).as_time,
        NumberFormatter.new(entry.diff_in_hours).as_prefixed_time,
      ]
    end

    Tablo::Table.new(table_data, connectors: Tablo::CONNECTORS_SINGLE_ROUNDED) do |t|
      t.add_column("Day", width: COLUMN_WIDTH) { |n| n[0] }
      t.add_column("Total hours", width: COLUMN_WIDTH, align_body: Tablo::Justify::Right) { |n| n[1] }
      t.add_column("Diff", width: COLUMN_WIDTH, align_body: Tablo::Justify::Right, styler: DIFF_STYLER) { |n| n[2] }
    end
  end

  def render_footer
    table_data = [
      [
        "Total",
        NumberFormatter.new(day_summary_entries.sum(&.sum_in_hours)).as_time,
        NumberFormatter.new(day_summary_entries.sum(&.diff_in_hours)).as_prefixed_time,
      ],
    ]

    Tablo::Table.new(table_data, connectors: Tablo::CONNECTORS_SINGLE_ROUNDED, header_frequency: nil) do |t|
      t.add_column("Total label", width: COLUMN_WIDTH) { |n| n[0] }
      t.add_column("Total hours", width: COLUMN_WIDTH, align_body: Tablo::Justify::Right) { |n| n[1] }
      t.add_column("Total diff", width: COLUMN_WIDTH, align_body: Tablo::Justify::Right, styler: DIFF_STYLER) { |n| n[2] }
    end
  end
end
