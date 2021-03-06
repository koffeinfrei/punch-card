require "yaml"

module I18n
  class Locale
    def self.current
      @@current ||=
        begin
          raw_locale = `env | grep LC_TIME`
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
      content = {{ read_file(path) }}
      yaml = YAML.parse(content)
      locale = Path[{{path}}].stem
      day_short_format = yaml[locale]["date_format"].as_s

      # month and year, without the day
      month_short = day_short_format
        .sub("%-d", "")
        .sub("%d", "")
        .sub("%e", "")
        .strip("/. ")

      LOCALIZED["#{locale}"] = {
        "day_short" => day_short_format,
        "day_with_name" => "%a  #{day_short_format}",
        "month_short" => month_short
      }
    {% end %}

    def self.get(name)
      return MONTH_WITH_NAME if name == "month_with_name"
      return TIME if name == "time"

      LOCALIZED[Locale.current][name]
    end
  end
end
