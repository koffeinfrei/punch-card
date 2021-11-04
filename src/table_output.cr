abstract class TableOutput
  COLUMN_WIDTH = 16

  abstract def render

  private def render_empty
    Tablo::Table.new([["No entries"]], connectors: Tablo::CONNECTORS_SINGLE_ROUNDED, header_frequency: nil) do |t|
      t.add_column("", width: 16) { |n| n[0] }
    end.to_s
  end
end
