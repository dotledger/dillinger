require 'ofx'

module Dillinger
  module Parser
    class Ofx < Base
      TYPES = {
        xfer: 'TRANSFER',
        pos: 'EFTPOS',
        directdebit: 'DIRECTDEBIT',
        directdep: 'DEPOSIT',
        debit: 'DEBIT'
      }

      def self.test(file)
        file.rewind
        OFX::Parser::Base.new(file)
        true
      rescue
        false
      end

      def parse
        ofx_parser.account.transactions.each do |t|
          transaction = Dillinger::Transaction.new
          transaction.amount      = t.amount.to_f
          transaction.date        = t.posted_at.to_date
          transaction.description = t.payee
          transaction.particulars = t.memo
          transaction.payee       = t.name
          transaction.reference   = t.ref_number
          transaction.type        = TYPES[t.type] || t.type
          transaction.unique_id   = t.fit_id

          add_transaction transaction
        end
      end

      private

      def ofx_parser
        file.rewind
        @ofx_parser ||= OFX::Parser::Base.new(file).parser
      end
    end
  end
end
