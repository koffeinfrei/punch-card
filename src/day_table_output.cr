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
          from = entry[:from][:time]
          to = entry[:to][:time]

          from_time =
            if entry[:from][:draft]
              "*#{DateFormatter.new(from).time}*"
            else
              DateFormatter.new(from).time
            end

          to_time =
            if to
              if entry[:to][:draft]
                "*#{DateFormatter.new(to).time}*"
              else
                DateFormatter.new(to).time
              end
            end

          "#{from_time} - #{to_time}"
        }.join("\n"),
        "#{"\n" * (span_count - 1)}#{NumberFormatter.new(day_summary_entry.sum_in_hours).as_time}",
        "#{"\n" * (span_count - 1)}#{NumberFormatter.new(day_summary_entry.diff_in_hours).as_prefixed_time}",
        day_summary_entry.projects.join("\n"),
      ],
    ]

    Tablo::Table.new(table_data, connectors: Tablo::CONNECTORS_SINGLE_ROUNDED) do |table|
      table.add_column("Entries", width: COLUMN_WIDTH, styler: HIGHLIGHT_STYLER) { |data| data[0] }
      table.add_column("Total hours", width: COLUMN_WIDTH, align_body: Tablo::Justify::Right) { |data| data[1] }
      table.add_column("Diff", width: COLUMN_WIDTH, align_body: Tablo::Justify::Right, styler: DIFF_STYLER) { |data| data[2] }
      table.add_column("Project", width: COLUMN_WIDTH, align_body: Tablo::Justify::Left) { |data| data[3] }
    end
  end

  def render_footer
  end
end
