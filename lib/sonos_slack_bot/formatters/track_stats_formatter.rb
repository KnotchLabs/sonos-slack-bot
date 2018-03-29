module SonosSlackBot::Formatters
  class TrackStatsFormatter
    include Helpers

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
        "#{TrackFormatter.new @track} has been played #{play_count} times "\
          "and was first played on #{first_played}."
      end
    end

    private

    def play_count
      @history.size
    end

    def first_played
      localize_timestamp_str @history.last
    end
  end
end
