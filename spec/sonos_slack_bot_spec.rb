require 'spec_helper'

RSpec.describe SonosSlackBot do
  it 'has a version number' do
    expect(described_class::VERSION).to_not be_nil
  end

  it 'has a config hash' do
    expect(described_class.config).to_not be_nil
  end
end
