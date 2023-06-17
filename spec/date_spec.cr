require "spec"
require "timecop"

require "../src/date"

describe Date do
  describe ".nowish" do
    it "rounds up to nearest 5min" do
      Timecop.freeze(Time.local(2021, 10, 30, 11, 3)) do
        Date.nowish.should eq Time.local(2021, 10, 30, 11, 5)
      end

      Timecop.freeze(Time.local(2021, 10, 30, 11, 58)) do
        Date.nowish.should eq Time.local(2021, 10, 30, 12, 0)
      end
    end

    it "rounds down to nearest 5min" do
      Timecop.freeze(Time.local(2021, 10, 30, 11, 2)) do
        Date.nowish.should eq Time.local(2021, 10, 30, 11, 0)
      end
    end
  end
end
