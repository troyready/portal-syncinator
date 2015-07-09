require 'spec_helper'

describe TrogdirChange do
  # TODO: test other fixtures
  let(:hash) { JSON.parse(File.read('./spec/fixtures/netid_addition.json')) }
  subject { TrogdirChange.new(hash) }

  describe '#sync_log_id' do
    it { expect(subject.sync_log_id).to eql '000000000000000000000000'}
  end

  describe '#person_uuid' do
    it { expect(subject.person_uuid).to eql '00000000-0000-0000-0000-000000000000'}
  end
  describe '#create?' do
    it { expect(subject.create?).to eql true}
  end

  describe '#netid?' do
    it { expect(subject.netid?).to eql true}
  end

  describe '#netid_changed?' do
    it { expect(subject.netid_changed?).to eql true}
  end
end
