require "./entry_type"

struct Entry
  property type, time

  def initialize(@type : EntryType, @time : Time)
  end
end
