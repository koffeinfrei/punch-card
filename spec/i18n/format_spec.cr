require "../../src/i18n"

describe I18n::Format do
  describe ".get('month_short')" do
    {% for locale, format in {de: "%m.%Y", es: "%-m/%Y", eu: "%Y/%m", km: "%B %Y"} %}
      it "returns '#{{{format}}}' for locale '{{locale}}'" do
        locale_before = I18n::Locale.current
        I18n::Locale.current = "{{locale}}"

        I18n::Format.get("month_short").should eq {{format}}

        I18n::Locale.current = locale_before
      end
    {% end %}
  end
end
