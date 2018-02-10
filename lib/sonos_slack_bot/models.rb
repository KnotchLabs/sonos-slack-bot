module SonosSlackBot
  module Models
    module Jsonable
      extend ActiveSupport::Concern

      def as_json(*)
        self.class.json_attributes.each.with_object({}) { |attr, memo| memo[attr] = send(attr) }
      end

      def to_json
        @to_json ||= super
      end

      module ClassMethods
        def json_attributes
          @json_attributes ||= []
        end

        def model_attr(*attrs)
          attrs.each do |attr|
            attr_reader attr
            json_attributes << attr
          end
        end

        def parse(json)
          return unless json

          args = JSON.parse(json)
          args.deep_symbolize_keys!

          new(**args)
        end
      end
    end
  end
end
