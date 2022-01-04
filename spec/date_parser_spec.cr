require "spec"
require "timecop"

require "../src/date_parser"

def now
  Time.local(2021, 10, 30, 11, 9)
end

def today
  Time.local(2021, 10, 30, 0, 0)
end

describe DateParser do
  around_each do |example|
    Timecop.freeze(now) do
      example.run
    end
  end

  around_each do |example|
    locale_before = I18n::Locale.current
    I18n::Locale.current = "de-CH"

    example.run

    I18n::Locale.current = locale_before
  end

  describe ".parse" do
    it "parses a time" do
      DateParser.parse("12:03").should eq Time.local(2021, 10, 30, 12, 3)
    end

    it "parses a date" do
      DateParser.parse("29.10.2021").should eq Time.local(2021, 10, 29, 0, 0)
    end

    it "parses 'today'" do
      DateParser.parse("today").should eq today
    end

    it "parses 'now'" do
      DateParser.parse("now").should eq now
    end

    it "parses 'yesterday'" do
      DateParser.parse("yesterday").should eq Time.local(2021, 10, 29, 0, 0)
    end

    it "parses a date time" do
      DateParser.parse("12:03 29.10.2021").should eq Time.local(2021, 10, 29, 12, 3)
    end

    it "raises an error on uparseable input" do
      expect_raises(Exception, "The input value 'asdf' is not an understood date format") do
        DateParser.parse("asdf")
      end
    end
  end

  describe DateParser::Month do
    describe ".parse?" do
      it "parses 'month'" do
        DateParser::Month.parse?("month").should eq({2021, 10})
      end

      it "parses a date consisting of month and year" do
        DateParser::Month.parse?("09.2021").should eq({2021, 9})
      end
    end
  end
end
