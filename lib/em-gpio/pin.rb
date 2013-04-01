module EventMachine
  module Gpio
    class Pin
      include Callbacks

      PINS  = 0..22
      MODES = [:in, :out]
      HIGH  = 1
      LOW   = 0

      attr_accessor :pin, :value, :last_value, :direction

      def initialize(pin, options={})
        @direction = options[:direction] || :out
        @pin       = pin
        validate
        setup_mode
      end

      def read
        @last_value = value
        @value      = adapter.read
      end

      def write(value)
        adapter.write(value)
      end

      def changed?
        value != last_value
      end

      private

      def validate
        raise "Invalid pin: #{pin}" unless PINS.include?(pin.to_i)
        raise "Invalid direction: #{direction}" unless MODES.include?(direction)
      end

      def setup_mode
        adapter.export!
        adapter.set_mode(direction)
        @last_value = adapter.read
      end

      def adapter
        @adapter ||= Adapter.new(pin)
      end
    end
  end
end