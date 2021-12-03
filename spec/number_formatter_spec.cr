require "spec"

require "../src/number_formatter"

describe NumberFormatter do
  describe ".as_time" do
    it "formats a positive number" do
      NumberFormatter.new(4.08).as_time.should eq "4:05"
    end
  end

  describe ".as_prefixed_time" do
    it "prefixes a positive number with '+'" do
      NumberFormatter.new(4.08).as_prefixed_time.should eq "+4:05"
    end

    it "prefixes a negative number with '-'" do
      NumberFormatter.new(-8.25).as_prefixed_time.should eq "-8:15"
    end

    it "prefixes negative zero with '-'" do
      NumberFormatter.new(-0.25).as_prefixed_time.should eq "-0:15"
    end
  end
end
