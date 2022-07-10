require "./entry_type"

record Store::Entry,
  id : String,
  type : EntryType,
  time : Time,
  project : String | Nil
