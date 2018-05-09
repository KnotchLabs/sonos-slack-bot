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
        "This track has been played #{play_count} #{time_pluralized} and was first played "\
          "on #{first_played} :chart_with_upwards_trend:"
      else
        "#{TrackFormatter.new @track} has been played #{play_count} #{time_pluralized} "\
          "and was first played on #{first_played}."
      end
    end

    private

    def time_pluralized
      'time'.pluralize(play_count)
    end

    def play_count
      @history.size
    end

    def first_played
      localize_timestamp_str @history.last
    end
  end
end
