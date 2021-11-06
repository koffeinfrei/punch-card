require "./entry_type"

class Store
  struct Entry
    property type, time

    def initialize(@type : EntryType, @time : Time)
    end
  end
end
