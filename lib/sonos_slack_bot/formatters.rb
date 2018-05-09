module SonosSlackBot
  module Formatters
    module Helpers
      DEFAULT_TZONE = '-05:00'.freeze

      def delimited_number(num)
        ActiveSupport::NumberHelper.number_to_delimited num
      end

      def localize_timestamp_str(ts)
        localize_timestamp(ts).strftime('%B %d, %Y at %I:%M %p')
      end

      def localize_timestamp(ts)
        Time.at(ts.to_i).localtime(SonosSlackBot.config.timezone || DEFAULT_TZONE)
      end
    end
  end
end
