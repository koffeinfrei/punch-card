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

  def insert(type, time, project = nil)
    with_database do |db|
      db.exec("INSERT INTO entries VALUES (?, ?, ?, ?)",
        UUID.random.to_s,
        time,
        type.to_i,
        project
      )
    end
  end

  def update(id, time)
    with_database do |db|
      db.exec("UPDATE entries SET time =  ? where uuid = ?",
        time,
        id
      )
    end
  end

  def select(time)
    data = [] of Entry
    with_database do |db|
      db.query(
        "SELECT uuid, time, type, project FROM entries WHERE strftime('%Y-%m-%d', time) = ? ORDER BY time ASC, type DESC",
        time.to_s("%Y-%m-%d")
      ) do |result|
        result.each do
          id, time, type, project = result.read(String, Time, Int, String | Nil)
          data << Entry.new(id, EntryType.from_value(type), time, project)
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
        type INTEGER NOT NULL,
        project TEXT NULL
      )
    SQL
    db.exec(create)

    # pseudo migrations, brute force our way to the latest schema
    begin
      db.exec("ALTER TABLE entries ADD COLUMN project TEXT")
    rescue
    end
  end
end
