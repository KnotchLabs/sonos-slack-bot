module SonosSlackBot::Formatters
  class TrackFormatter
    def initialize(track)
      @track = track
    end

    def to_s
      if @track.album then "#{@track.title} by #{@track.artist} on #{@track.album}"
      else "#{@track.title} by #{@track.artist}"
      end
    end
  end
end
