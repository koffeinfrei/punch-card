require "yaml"

module I18n
  class Locale
    def self.current
      @@current ||=
        begin
          raw_locale = `locale | grep LC_TIME`
          # the environment variable on linux is in the form of
          # `LC_TIME=de_CH.UTF-8`
          locale = raw_locale
            .split("=")[1]?
            .try(&.split(".")[0]?)
            .try(&.sub("_", "-"))

          locale || "en"
        end
    end

    def self.current=(value)
      @@current = value
    end
  end

  class Format
    LOCALIZED       = Hash(String, Hash(String, String)).new
    MONTH_WITH_NAME = "%b %Y"
    TIME            = "%H:%M"

    macro define_locale(name, day_short_format)
      LOCALIZED["#{ {{name}} }"] = {
        "day_short" => "#{ {{day_short_format}} }",
        "day_with_name" => "%a  #{ {{day_short_format}} }"
      }
    end

    Dir.glob("#{__DIR__}/locales/*.yml").each do |path|
      locale = Path[path].stem

      yaml = File.open(path) { |file| YAML.parse(file) }
      define_locale(locale, yaml[locale]["date_format"].as_s)
    end

    def self.get(name)
      return MONTH_WITH_NAME if name == "month_with_name"
      return TIME if name == "time"

      LOCALIZED[Locale.current][name]
    end
  end
end
