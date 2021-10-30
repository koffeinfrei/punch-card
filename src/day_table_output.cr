require "./day_summary"

class DayTableOutput
  getter day_summary_entry

  def initialize(@day_summary_entry : DaySummaryEntry)
  end

  def render
    diff_in_hours = day_summary_entry.diff_in_hours
    if diff_in_hours.positive?
      diff_in_hours = "+#{diff_in_hours}"
    end
    span_count = day_summary_entry.spans.size
    table_data = [
      [
        day_summary_entry.spans.map { |entry|
          from = entry[:from]
          to = entry[:to]

          # TODO this is just for the compiler.
          return if from.nil? || to.nil?

          "#{from.to_s("%H:%M")} - #{to.to_s("%H:%M")}"
        }.join("\n"),
        "#{"\n" * (span_count - 1)}#{day_summary_entry.sum_in_hours}",
        "#{"\n" * (span_count - 1)}#{diff_in_hours}",
      ],
    ]
    table = Tablo::Table.new(table_data, connectors: Tablo::CONNECTORS_SINGLE_ROUNDED) do |t|
      t.add_column("Entries", width: 16) { |n| n[0] }
      t.add_column("Total hours", width: 16, align_body: Tablo::Justify::Right) { |n| n[1] }
      t.add_column("Diff", width: 16, align_body: Tablo::Justify::Right) { |n| n[2] }
    end

    puts "╭──────────────────╮"
    puts "│ 📅  2021-10-26   │"
    puts table
  end
end
