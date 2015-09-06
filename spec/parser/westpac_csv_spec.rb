require 'spec_helper'

describe Dillinger::Parser::WestpacCsv do
  let(:statement_file) { fixture('example_westpac_csv.csv') }
  let(:other_file) { fixture('example_ofx.ofx') }

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
      expect(subject.transactions.map(&:unique_id)).to eq %w(1639fc32c7a91d790154c289a1074dc00381091318222cd01938825decd2cfbc aec13f2da75476a5dfa30aa06731226dda8baa366f277462d43b229f7033f54b ad0c849fc78c469770d9380e6e3a8237425eafb9067e1d85ddf37b9a284349ba 22bdba973f86363a986c7cc4918d630177cf9df00d06aeec768ab7c8e0277302)
    end
  end
end
