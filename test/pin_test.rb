require_relative 'test_helper'
require 'mocha/setup'

describe "Pin" do
  def setup
    EM::Gpio::Adapter.any_instance.stubs(:export!).returns(true)
    EM::Gpio::Adapter.any_instance.stubs(:set_mode).returns('in')
    EM::Gpio::Adapter.any_instance.stubs(:read).returns(1)
  end

  it "should detect an invalid GPIO pin" do
    EM::Gpio::Pin.any_instance.stubs(:setup_mode).returns(nil)
    (0..22).each do |n|
      EM::Gpio::Pin.new(n).must_be_instance_of EM::Gpio::Pin
    end

    [25, 100].each do |n|
      proc{ EM::Gpio::Pin.new(n) }.must_raise RuntimeError
    end
  end

  it "should read the initial state after initialization" do
    pin = EM::Gpio::Pin.new 5
    pin.last_value.must_be :==, 1
  end
end