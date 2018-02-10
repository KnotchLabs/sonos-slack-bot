### HACKS

```ruby
speaker = Sonos::Device::Speaker.new('192.168.100.99')

def speaker.group_master; OpenStruct.new(ip: '192.168.100.99'); end

speaker.now_playing
```

#### Now Playing Data

```ruby
{:title=>"Mr. Brightside", :artist=>"The Killers", :album=>"Hot Fuss", :info=>"", :queue_position=>"1", :track_duration=>"0:03:42", :current_position=>"0:00:00", :uri=>"x-sonos-spotify:spotify%3atrack%3a4L3sku3mPh6uWGNA63VCgu?sid=12&flags=8224&sn=10", :album_art=>"http://192.168.100.99:1400/getaa?s=1&u=x-sonos-spotify%3aspotify%253atrack%253a4L3sku3mPh6uWGNA63VCgu%3fsid%3d12%26flags%3d8224%26sn%3d10"}

{:title=>"Think Before I Talk", :artist=>"Astrid S", :album=>"Think Before I Talk", :info=>"", :queue_position=>"1", :track_duration=>"0:03:04", :current_position=>"0:01:23", :uri=>"x-sonos-spotify:spotify%3atrack%3a0Clb9aiXWa0dvVff5aN4VN?sid=12&flags=8224&sn=15", :album_art=>"http://192.168.100.99:1400/getaa?s=1&u=x-sonos-spotify%3aspotify%253atrack%253a0Clb9aiXWa0dvVff5aN4VN%3fsid%3d12%26flags%3d8224%26sn%3d15"}

{:title=>"Never Gonna Give You Up", :artist=>"Barry White", :album=>"The Greatest Hits: Barry White - Love Serenade", :info=>"", :queue_position=>"3", :track_duration=>"0:04:46", :current_position=>"0:00:56", :uri=>"x-sonosapi-hls-static:catalog%2ftracks%2fB00RW24488%2f%3falbumAsin%3dB00RW2426C?sid=201&flags=0&sn=12", :album_art=>"http://192.168.100.99:1400/getaa?s=1&u=x-sonosapi-hls-static%3acatalog%252ftracks%252fB00RW24488%252f%253falbumAsin%253dB00RW2426C%3fsid%3d201%26flags%3d0%26sn%3d12"}

{:title=>"x-sonosapi-hls:hls:ra.978194965?sid=204&flags=8224&sn=11", :artist=>"", :album=>"", :info=>"TYPE=SNG|TITLE Like I Love You (feat. Clipse)|ARTIST Justin Timberlake featuring Clipse|ALBUM Justified", :queue_position=>"1", :track_duration=>"0:00:00", :current_position=>"0:11:18", :uri=>"x-sonosapi-hls:hls%3ara.978194965?sid=204&flags=8224&sn=11", :album_art=>"http://192.168.100.99:1400http://itsliveradio.apple.com/bb/images/b1/571b8867-21b0-4f67-9a8d-f7113c2cdbff.jpg"}
```

#### Useful methods

```ruby
speaker.is_playing?
speaker.has_music?
```

```
[:add_rdio_to_queue, :add_spotify_to_queue, :add_to_queue, :bass,
:bass=, :clear_queue, :container_contents, :create_alarm,
:create_pair_with, :crossfade_off, :crossfade_on, :data, :data=,
:destroy_alarm, :disable_alarm, :enable_alarm, :get_player_state,
:get_playmode, :group, :group_master, :group_master=, :hardware_version,
:has_music?, :icon, :ip, :is_alarm_enabled?, :is_playing?, :join,
:line_in, :list_alarms, :loudness, :loudness=, :mac_address, :model,
:model_number, :mute, :muted?, :next, :now_playing, :parse_response,
:pause, :play, :play_blocking, :previous, :queue, :radio_stations,
:remove_from_queue, :repeat_off, :repeat_on, :save_queue, :seek,
:select_track, :separate_pair, :serial_number, :services,
:set_alarm_volume, :set_crossfade, :set_playmode, :set_sleep_timer,
:shuffle_off, :shuffle_on, :shuffle_repeat_change, :software_version,
:speaker?, :status_light_enabled=, :status_light_enabled?, :stop,
:subscribe_to_upnp_events, :treble, :treble=, :uid, :ungroup, :unmute,
:unsubscribe_from_upnp_events, :update_alarm, :voiceover!, :volume,
:volume=, :with_isolated_state, :zone_type]
```
