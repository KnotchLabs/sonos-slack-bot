module SonosSlackBot::Formatters
  class TopicFormatter
    def initialize(speaker)
      @speaker = speaker
    end

    def to_s
      if @speaker.playing?
        ":musical_note: #{TrackFormatter.new(@speaker.track)} :musical_note:"
      elsif @speaker.connected?
        'There is no music playing -- the silence is deafening :worried:'
      else
        'Cannot connect to the Sonos speaker :frowning:'
      end
    end
  end
end
