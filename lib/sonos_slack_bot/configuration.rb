module SonosSlackBot
  class Configuration
    attr_reader :struct

    def self.load(file_path)
      new(file_path).struct
    end

    def initialize(file_path)
      @struct = hash_to_struct(YAML.load_file(file_path))
    end

    private

    def hash_to_struct(hash)
      OpenStruct.new.tap do |struct|
        hash.each do |key, value|
          if Hash === value then struct[key] = hash_to_struct(value)
          else struct[key] = value
          end
        end
      end
    end
  end
end
