require "./day_summary"
require "./date_formatter"
require "./number_formatter"
require "./table_output"

class DayTableOutput < TableOutput
  getter day_summary_entry

  def initialize(@day_summary_entry : DaySummaryEntry)
  end

  def render
    output = [] of String
    output << "╭──────────────────╮"
    output << "│ 📅  #{DateFormatter.new(day_summary_entry.day).day_short}   │"

    if day_summary_entry.empty?
      output << render_empty.to_s
    else
      output << render_table.to_s
    end

    output.join("\n")
  end

  private def render_table
    span_count = day_summary_entry.spans.size

    table_data = [
      [
        day_summary_entry.spans.map { |entry|
          from = entry[:from]
          to = entry[:to]

          # TODO this is just for the compiler.
          return if from.nil? || to.nil?

          "#{DateFormatter.new(from).time} - #{DateFormatter.new(to).time}"
        }.join("\n"),
        "#{"\n" * (span_count - 1)}#{NumberFormatter.new(day_summary_entry.sum_in_hours).rounded}",
        "#{"\n" * (span_count - 1)}#{NumberFormatter.new(day_summary_entry.diff_in_hours).rounded_and_prefixed}",
      ],
    ]

    Tablo::Table.new(table_data, connectors: Tablo::CONNECTORS_SINGLE_ROUNDED) do |t|
      t.add_column("Entries", width: 16) { |n| n[0] }
      t.add_column("Total hours", width: 16, align_body: Tablo::Justify::Right) { |n| n[1] }
      t.add_column("Diff", width: 16, align_body: Tablo::Justify::Right) { |n| n[2] }
    end.to_s
  end
end
