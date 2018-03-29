module SonosSlackBot::Formatters
  class EmptyHistoryFormatter
    def initialize(user_info)
      @user_info = user_info
    end

    def to_s
      "Sorry #{user_info.profile.display_name}, no tracks have been played yet."
    end
  end
end
