require 'spec_helper'

describe Dillinger::Parser::Ofx do
  let(:statement_file) { fixture('example_ofx.ofx') }
  let(:other_file) { fixture('example_qif.qif') }

  subject { described_class.new(statement_file) }

  describe '.test' do
    specify do
      expect(described_class.test(statement_file)).to be true
    end

    specify do
      expect(described_class.test(other_file)).to be false
    end
  end

  describe '#parse' do
    before do
      subject.parse
    end

    it 'has the correct transaction amounts' do
      expect(subject.transactions.map(&:amount)).to eq [
        -500.0,
        -3.8,
        -456.78,
        5678.9
      ]
    end

    it 'has the correct transaction types' do
      expect(subject.transactions.map(&:type)).to eq %w(TRANSFER EFTPOS DEBIT DEPOSIT)
    end

    it 'has the correct transaction dates' do
      expect(subject.transactions.map(&:date)).to eq [
        Date.new(2014, 12, 20),
        Date.new(2014, 12, 21),
        Date.new(2014, 12, 22),
        Date.new(2014, 12, 23)
      ]
    end

    it 'has the correct transaction unique ids' do
      expect(subject.transactions.map(&:unique_id)).to eq %w(2014122001 2014122101 2014122201 2014122301)
    end
  end
end
