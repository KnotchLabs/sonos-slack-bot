module SonosSlackBot::Formatters
  class StatsFormatter
    include Helpers

    def initialize(count, top_5)
      @count = count
      @top_5 = top_5
    end

    def to_s
      "There have been #{delimited_number @count} tracks played. The top 5 tracks over all are:\n#{top_5_str}"
    end

    private

    def top_5_str
      @top_5.each_with_object('').with_index do |((track, count), str), index|
        str << "#{index + 1}. #{TrackFormatter.new(track)} played #{count} times\n"
      end
    end
  end
end
