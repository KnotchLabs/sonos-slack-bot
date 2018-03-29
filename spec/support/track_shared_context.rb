shared_context 'track_model' do
  let(:title) { 'One Click' }
  let(:artist) { 'The Knotchs' }
  let(:album) { 'In The Measurement' }

  let(:now_playing_base) do
    { title: title,
      artist: artist,
      album: album,
      queue_position: '1',
      track_duration: '0:03:55',
      current_position: '0:01:23',
      uri: 'x-sonos-spotify:foo',
      album_art: 'http://1.2.3.4:1400/getaa?foo'}
  end

  let(:x_sonosapi_now_playing_base) do
    now_playing_base.update(
      title: 'x-sonosapi-hls:foo',
      artist: '',
      album: '',
      info: "TYPE=SNG|TITLE #{title}|ARTIST #{artist}|ALBUM #{album}")
  end

  let(:track) { SonosSlackBot::Models::Track.new title: title, artist: artist, album: album }
end
