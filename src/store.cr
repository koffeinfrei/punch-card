require "sqlite3"
require "uuid"

require "./store/entry"
require "./store/entry_type"

class Store
  {% if flag?(:release) %}
    FILE = Path.home.join(".config", "punch-card", "data.db")
  {% else %}
    FILE = "./data.db"
  {% end %}

  def insert(type, time)
    with_database do |db|
      db.exec("INSERT INTO entries VALUES (?, ?, ?)", UUID.random.to_s, time, type.to_i)
    end
  end

  def select(time)
    data = [] of Entry
    with_database do |db|
      db.query "SELECT time, type FROM entries WHERE strftime('%Y-%m-%d', time) = ? ORDER BY time", time.to_s("%Y-%m-%d") do |result|
        result.each do
          time, type = result.read(Time, Int)
          data << Entry.new(EntryType.from_value(type), time)
        end
      end
    end

    data
  end

  private def with_database
    Dir.mkdir_p(File.dirname(FILE))

    DB.open "sqlite3://#{FILE}" do |db|
      create_database(db)

      yield db
    end
  end

  private def create_database(db)
    create = <<-SQL
      CREATE TABLE IF NOT EXISTS entries (
        uuid TEXT NOT NULL,
        time TEXT NOT NULL,
        type INTEGER NOT NULL
      )
    SQL
    db.exec(create)
  end
end
