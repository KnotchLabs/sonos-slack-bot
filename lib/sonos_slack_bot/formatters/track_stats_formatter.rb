module SonosSlackBot::Formatters
  class TrackStatsFormatter
    def initialize(track, history, **options)
      @track = track
      @history = history
      @options = options
    end

    def to_s
      if @options[:as_event]
        "This track has been played #{play_count} times and was first played "\
          "on #{first_played} :chart_with_upwards_trend:"
      else
        "#{TrackFormatter.new(@track)} has been played #{play_count} times "\
          "and was first played on #{first_played}."
      end
    end

    private

    def play_count
      @history.size
    end

    def first_played
      Time.at(@history.last.to_i).strftime('%B %d, %Y at %H:%M %p')
    end
  end
end
