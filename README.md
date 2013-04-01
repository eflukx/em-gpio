# EM::Gpio

EM::Gpio is an eventmachine compatible gpio library for raspberry-pi.

## Installation

Add this line to your application's Gemfile:

    gem 'em-gpio'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install em-gpio

## Usage

    EM.run do
      pin = EM::Gpio::Pin.new(10, :direction => :in)

      pin.callback do
        # called when pin value changes
      end

      pin.callback :on => :high do
        # called on :low to :high transition
      end

      pin.callback :on => :low do
        # called on :high to :low transition
      end
    end

## TODO

1. SerialPort support
2. Example rack app
3. Find time for 1 and 2
