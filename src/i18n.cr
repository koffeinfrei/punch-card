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

    {% for path in `ls -d -1 "#{__DIR__}/locales"/*`.lines %}
      yaml = File.open({{path}}) { |file| YAML.parse(file) }
      locale = Path[{{path}}].stem
      day_short_format = yaml[locale]["date_format"].as_s

      LOCALIZED["#{locale}"] = {
        "day_short" => "#{day_short_format}",
        "day_with_name" => "%a  #{day_short_format}"
      }
    {% end %}

    def self.get(name)
      return MONTH_WITH_NAME if name == "month_with_name"
      return TIME if name == "time"

      LOCALIZED[Locale.current][name]
    end
  end
end
