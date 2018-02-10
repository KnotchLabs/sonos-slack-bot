require 'spec_helper'

RSpec.describe SonosSlackBot::Models::Track do
  include_context 'track_model'

  describe '#to_json' do
    subject { track.to_json }

    it { expect(subject).to eq("{\"title\":\"#{title}\",\"artist\":\"#{artist}\",\"album\":\"#{album}\"}") }
  end

  describe '#id' do
    subject { track.id }

    it { expect(subject).to eq('6553a972a093ef766f16af996348b2e4') }
  end

  describe '<=>' do
    subject { track }

    context 'when the same' do
      let(:track_two) { described_class.new title: title, artist: artist, album: album }

      it { expect(subject).to eq(track_two) }
    end

    context 'when not the same' do
      let(:track_two) do
        described_class.new title: "#{title} (Remix)", artist: artist, album: album
      end

      it { expect(subject).to_not eq(track_two) }
    end
  end
end
