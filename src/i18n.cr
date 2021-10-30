module I18n
  class Locale
    def self.current
      @@current_locale ||=
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
  end
end
