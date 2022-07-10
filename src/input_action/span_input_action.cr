require "../input_action"
require "../input_action/show_day_input_action"

class InputAction
  class SpanInputAction < InputAction
    def matches?
      input.includes?("-")
    end

    def run
      # a) hh:mm-hh:mm
      # b) hh:mm-hh:mm mm.yyyy
      start, stop_and_date = input.split("-")
      stop_and_date = stop_and_date.split(" ")
      stop, date = stop_and_date[0], stop_and_date[1]?

      # a) hh:mm
      # b) hh:mm mm.yyyy
      start = [start, date].compact.join(" ")
      stop = [stop, date].compact.join(" ")

      store = Store.new
      store.insert(Store::EntryType::Start, DateParser.parse(start), project)
      store.insert(Store::EntryType::Stop, DateParser.parse(stop))

      ShowDayInputAction.new(start).run
    end

    def self.description
      {
        "Add an entry",
        <<-DESC
          <start time>-<stop time> [date]
              A time span of work
              Must be in the format '<from>-<to>'
              <from> and <to> can be 'now' or a specific time like '#{DateFormatter.new(DateParser.parse("17:30")).time}'
              The date is 'today' by default
          DESC
      }
    end
  end
end
