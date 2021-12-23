require "./entry_type"

class Store
  struct Entry
    property type, time, project

    def initialize(@type : EntryType, @time : Time, @project : String | Nil)
    end
  end
end
