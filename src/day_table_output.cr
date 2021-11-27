require "./day_summary"
require "./date_formatter"
require "./number_formatter"
require "./table_output"

class DayTableOutput < TableOutput
  getter day_summary_entry

  def initialize(@day_summary_entry : DaySummaryEntry)
  end

  def empty?
    day_summary_entry.empty?
  end

  def header_content
    DateFormatter.new(day_summary_entry.day).day_short
  end

  def render_table
    span_count = day_summary_entry.spans.size

    table_data = [
      [
        day_summary_entry.spans.map { |entry|
          from = entry[:from]
          to = entry[:to]

          if to
            "#{DateFormatter.new(from).time} - #{DateFormatter.new(to).time}"
          else
            "#{DateFormatter.new(from).time} - "
          end
        }.join("\n"),
        "#{"\n" * (span_count - 1)}#{NumberFormatter.new(day_summary_entry.sum_in_hours).rounded}",
        "#{"\n" * (span_count - 1)}#{NumberFormatter.new(day_summary_entry.diff_in_hours).rounded_and_prefixed}",
      ],
    ]

    Tablo::Table.new(table_data, connectors: Tablo::CONNECTORS_SINGLE_ROUNDED) do |t|
      t.add_column("Entries", width: COLUMN_WIDTH) { |n| n[0] }
      t.add_column("Total hours", width: COLUMN_WIDTH, align_body: Tablo::Justify::Right) { |n| n[1] }
      t.add_column("Diff", width: COLUMN_WIDTH, align_body: Tablo::Justify::Right, styler: DIFF_STYLER) { |n| n[2] }
    end
  end

  def render_footer
  end
end
