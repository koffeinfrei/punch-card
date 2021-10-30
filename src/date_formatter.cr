require "yaml"

class DateFormatter
  LOCALES = Hash(String, Hash(String, String)).new

  macro define_locale(name, day_short_format)
    LOCALES["#{ {{name}} }"] = {
      "day_short" => "#{ {{day_short_format}} }",
      "day_with_name" => "%a  #{ {{day_short_format}} }"
    }
  end

  Dir.glob("#{__DIR__}/locales/*.yml").each do |path|
    locale = Path[path].stem

    yaml = File.open(path) { |file| YAML.parse(file) }
    define_locale(locale, yaml[locale]["date_format"].as_s)
  end

  MONTH_WITH_NAME = "%b %Y"
  TIME            = "%H:%M"

  getter date, locale

  def initialize(@date : Time, @locale = "de-CH")
  end

  def day_short
    date.to_s(LOCALES[locale]["day_short"])
  end

  def day_with_name
    date.to_s(LOCALES[locale]["day_with_name"])
  end

  def month_with_name
    date.to_s(MONTH_WITH_NAME)
  end

  def time
    date.to_s(TIME)
  end
end
