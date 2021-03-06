require 'helper'
require 'flipper/typecast'

describe Flipper::Typecast do
  {
    nil => false,
    "" => false,
    0 => false,
    1 => true,
    "0" => false,
    "1" => true,
    true => true,
    false => false,
    "true" => true,
    "false" => false,
  }.each do |value, expected|
    context "#to_boolean for #{value.inspect}" do
      it "returns #{expected}" do
        described_class.to_boolean(value).should be(expected)
      end
    end
  end

  {
    nil => 0,
    "" => 0,
    0 => 0,
    1 => 1,
    "1" => 1,
    "99" => 99,
  }.each do |value, expected|
    context "#to_integer for #{value.inspect}" do
      it "returns #{expected}" do
        described_class.to_integer(value).should be(expected)
      end
    end
  end

  {
    nil => Set.new,
    "" => Set.new,
    Set.new([1, 2]) => Set.new([1, 2]),
    [1, 2] => Set.new([1, 2])
  }.each do |value, expected|
    context "#to_set for #{value.inspect}" do
      it "returns #{expected}" do
        described_class.to_set(value).should eq(expected)
      end
    end
  end

  it "raises argument error for integer value that cannot be converted to an integer" do
    expect {
      described_class.to_integer(["asdf"])
    }.to raise_error(ArgumentError, %Q(["asdf"] cannot be converted to an integer))
  end

  it "raises argument error for set value that cannot be converted to a set" do
    expect {
      described_class.to_set("asdf")
    }.to raise_error(ArgumentError, %Q("asdf" cannot be converted to a set))
  end
end
