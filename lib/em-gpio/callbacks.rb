module EventMachine
  module Gpio
    module Callbacks

      VALID_ON_OPTIONS = [:change, :high, :low]

      def callback(options={}, &handler)
        callback_wrapper do
          event = options.fetch(:on, :change)
          raise(ArgumentError, "Unknown event #{on.inspect} specified") unless VALID_ON_OPTIONS.include?(event)
          instance_variable_set("@on_#{event}", handler)
        end
        self
      end

      private

      def callback_wrapper
        EM.next_tick do
          yield
          eventable_read
        end
      end

      def eventable_read
        read
        trigger_callbacks
      end

      def trigger_callbacks
        callback_wrapper do
          if changed?
            _trigger :change if @value && @last_value
            _trigger :low    if @value == Pin::LOW
            _trigger :high   if @value == Pin::HIGH
          end
        end
      end

      def _trigger(event)
        handler = instance_variable_get("@on_#{event}")
        handler.call(value) if handler
      end
    end
  end
end