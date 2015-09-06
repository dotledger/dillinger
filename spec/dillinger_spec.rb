require 'spec_helper'

describe Dillinger do
  it 'has a version number' do
    expect(Dillinger::VERSION).not_to be nil
  end

  describe 'invalid file' do
    subject { described_class.new(fixture('blank.txt')) }

    it 'is false' do
      expect(subject).to be false
    end
  end

  describe 'QIF' do
    subject { described_class.new(fixture('example_qif.qif')) }

    it 'selects the corect parser for QIF format' do
      expect(subject).to be_instance_of(Dillinger::Parser::Qif)
    end
  end

  describe 'OFX' do
    subject { described_class.new(fixture('example_ofx.ofx')) }

    it 'selects the corect parser for OFX format' do
      expect(subject).to be_instance_of(Dillinger::Parser::Ofx)
    end
  end

  describe 'Westpac CSV' do
    subject { described_class.new(fixture('example_westpac_csv.csv')) }

    it 'selects the corect parser for Westpac CSV format' do
      expect(subject).to be_instance_of(Dillinger::Parser::WestpacCsv)
    end
  end

  describe 'ASB CSV' do
    subject { described_class.new(fixture('example_asb_csv.csv')) }

    it 'selects the corect parser for ASB CSV format' do
      expect(subject).to be_instance_of(Dillinger::Parser::AsbCsv)
    end
  end

  describe 'ASB TDV' do
    subject { described_class.new(fixture('example_asb_tdv.tdv')) }

    it 'selects the corect parser for ASB TDV format' do
      expect(subject).to be_instance_of(Dillinger::Parser::AsbTdv)
    end
  end
end
