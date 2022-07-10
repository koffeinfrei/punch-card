require "../input_action"

class InputAction
  class AmendInputAction < InputAction
    def matches?
      input.starts_with?("amend ")
    end

    def run
      store = Store.new
      entry = store.select(Time.local).last
      time = input.split(" ", limit: 2).last
      store.update(entry.id, DateParser.parse(time))

      ShowDayInputAction.new(time).run
    end

    def self.description
      {
        "Amends the last entry",
        <<-DESC
          amend <time>
              The time you want to update the last entry with
              Can be 'now' or a specific time like '#{DateFormatter.new(DateParser.parse("08:15")).time}'
          DESC
      }
    end
  end
end
