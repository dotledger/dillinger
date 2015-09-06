require 'spec_helper'

describe Dillinger::Parser::AsbCsv do
  let(:statement_file) { fixture('example_asb_csv.csv') }
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
      expect(subject.transactions.map(&:unique_id)).to eq %w(4f572a400796a3304b67b13f9fd8eabb00e70c5bc50c212c44b6716b0b4abb5a b5264781928fd04c6ada530a97755ad58ba2aeb2f26e65ec7960cd240d9b2a05 ba3594e8b4042c94268ab26ce12c13086d08e62c7f7e24730abfc29d2fd754fd b6fe974ae17fa9fc799b31cd6251ecbb3ab9f7a498a7bc72acc4503e24229b3e)
    end
  end
end
