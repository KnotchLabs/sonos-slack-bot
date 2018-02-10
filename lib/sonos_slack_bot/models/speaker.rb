module SonosSlackBot::Models
  class Speaker
    include Jsonable
    include Comparable

    model_attr :track

    def initialize(connected: true, track: nil)
      @connected = connected
      @track = Hash === track ? Track.new(**track) : track
    end

    def playing?
      !@track.nil?
    end

    def connected?
      @connected
    end

    def <=>(other)
      return if other.nil?

      connected? <=> other.connected? &&
        playing? <=> other.playing? &&
        track <=> other.track
    end
  end
end
