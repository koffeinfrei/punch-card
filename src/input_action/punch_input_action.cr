require "colorize"
require "../input_action"
require "../date"

class InputAction
  class PunchInputAction < InputAction
    def matches?
      input == "punch"
    end

    def run
      entries = Store.new.select(Time.local)
      latest_entry = entries.try(&.last?)

      type =
        if latest_entry && latest_entry.start?
          Store::EntryType::Stop
        else
          Store::EntryType::Start
        end

      nowish = Date.nowish

      new_entry = Store::Entry.new(nil, type, nowish, project)
      entries << new_entry
      day_summary_entry = DaySummary.new(nowish, entries).get

      puts DayTableOutput.new(day_summary_entry).render
      print "  ➜   Ok to add the highlighted entry? [y/n]: ".colorize(:blue)

      if gets == "y"
        Store.new.insert(type, Date.nowish, project)

        ShowDayInputAction.new(DateFormatter.new(Time.local).day_short).run
      end
    end

    def self.description
      {
        "Add an entry",
        <<-DESC
          punch
              Adds an entry, depending on whether the next entry is start or stop.
              The time is round to the nearest 5 minute.
              The date is 'today'
          DESC
      }
    end
  end
end
