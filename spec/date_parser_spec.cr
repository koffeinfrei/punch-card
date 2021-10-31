require "spec"
require "timecop"

require "../src/date_parser"

def now
  Time.local(2021, 10, 30, 11, 9)
end

describe DateParser do
  describe ".parse" do
    around_each do |example|
      Timecop.freeze(now) do
        example.run
      end
    end

    it "parses a time" do
      DateParser.parse("12:03").should eq Time.local(2021, 10, 30, 12, 3)
    end

    it "parses a date" do
      DateParser.parse("29.10.2021").should eq Time.local(2021, 10, 29, 0, 0)
    end

    it "parses 'today'" do
      DateParser.parse("today").should eq now
    end

    it "parses 'now'" do
      DateParser.parse("now").should eq now
    end

    it "parses 'yesterday'" do
      DateParser.parse("yesterday").should eq Time.local(2021, 10, 29, 11, 9)
    end

    it "raises an error on uparseable input" do
      expect_raises(Exception, "The input value 'asdf' is not an understood date format") do
        DateParser.parse("asdf")
      end
    end
  end
end