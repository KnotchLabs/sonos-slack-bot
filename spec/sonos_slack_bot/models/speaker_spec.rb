require 'spec_helper'

RSpec.describe SonosSlackBot::Models::Speaker do
  include_context 'track_model'

  let(:disconnected_speaker) { described_class.new connected: false }
  let(:not_playing_speaker) { described_class.new connected: true }
  let(:playing_speaker) { described_class.new connected: true, track: track }

  describe '#connected?' do
    context 'with disconnected speaker' do
      subject { disconnected_speaker.connected? }

      it { expect(subject).to be(false) }
    end

    context 'with connected not playing speaker' do
      subject { not_playing_speaker.connected? }

      it { expect(subject).to be(true) }
    end

    context 'with playing speaker' do
      subject { playing_speaker.connected? }

      it { expect(subject).to be(true) }
    end
  end

  describe '#playing?' do
    context 'with disconnected speaker' do
      subject { disconnected_speaker.playing? }

      it { expect(subject).to be(false) }
    end

    context 'with connected not playing speaker' do
      subject { not_playing_speaker.playing? }

      it { expect(subject).to be(false) }
    end

    context 'with playing speaker' do
      subject { playing_speaker.playing? }

      it { expect(subject).to be(true) }
    end
  end

  describe '#<=>' do
    it { expect(disconnected_speaker).to eq(disconnected_speaker) }
    it { expect(not_playing_speaker).to eq(not_playing_speaker) }
    it { expect(playing_speaker).to eq(playing_speaker) }

    it { expect(disconnected_speaker).to_not eq(playing_speaker) }
    it { expect(disconnected_speaker).to_not eq(not_playing_speaker) }

    it { expect(not_playing_speaker).to_not eq(playing_speaker) }

    context 'with nil' do
      it { expect(disconnected_speaker).to_not eq(nil) }
      it { expect(not_playing_speaker).to_not eq(nil) }
      it { expect(playing_speaker).to_not eq(nil) }
    end
  end
end
