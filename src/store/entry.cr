require "./entry_type"

record Store::Entry,
  type : EntryType,
  time : Time,
  project : String | Nil
