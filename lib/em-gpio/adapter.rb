module EventMachine
  module Gpio
    class Adapter

      attr_accessor :pin

      BASE_PATH = "/sys/class/gpio/"

      def initialize(pin)
        @pin = pin
      end

      def read
        File.read(BASE_PATH + "gpio#{pin}/value").to_i
      end

      def write(value)
        File.open(BASE_PATH + "gpio#{pin}/value", "w"){|f| f.write(value)}
      end

      def set_mode(direction)
        File.open(BASE_PATH + "gpio#{pin}/direction", "w"){|f| f.write(direction)}
      end

      def export!
        File.open(BASE_PATH + "export", "w"){|f| f.write(pin)}
      end
    end
  end
end