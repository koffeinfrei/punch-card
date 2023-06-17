require "./entry_type"

record Store::Entry,
  id : String | Nil,
  type : EntryType,
  time : Time,
  project : String | Nil do
  def start?
    type == EntryType::Start
  end
end
