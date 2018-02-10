shared_context 'track_model' do
  let(:title) { 'One Click' }
  let(:artist) { 'The Knotchs' }
  let(:album) { 'In The Measurement' }

  let(:track) { SonosSlackBot::Models::Track.new title: title, artist: artist, album: album }
end
