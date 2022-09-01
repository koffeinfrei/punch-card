require "spec"

require "../src/number_formatter"

describe NumberFormatter do
  describe ".as_time" do
    it "formats a positive number" do
      NumberFormatter.new(4.08).as_time.should eq "4:05"
    end

    it "converts rounded up 60 minutes to 1 hour" do
      NumberFormatter.new(4.999).as_time.should eq "5:00"
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

    it "does not prefix zero" do
      NumberFormatter.new(0).as_prefixed_time.should eq "0:00"
    end
  end
end
