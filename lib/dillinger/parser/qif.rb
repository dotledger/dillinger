require 'qif'

module Dillinger
  module Parser
    class Qif < Base
      TYPES = {
        'TFROUT' => 'TRANSFER',
        'EFTPOS' => 'EFTPOS',
        'DIRDEB' => 'DIRECTDEBIT',
        'DIRCRE' => 'DIRECTCREDIT',
        'LOANRE' => 'DEBIT',
        'DEPOSIT' => 'DEPOSIT'
      }

      def self.test(file)
        file.rewind
        ::Qif::Reader.new(file)
        true
      rescue
        false
      end

      def parse
        qif_parser.transactions.each do |t|
          transaction = Dillinger::Transaction.new
          transaction.amount      = t.amount.to_f
          transaction.date        = t.date
          transaction.description = ''
          transaction.particulars = t.memo
          transaction.payee       = t.payee.to_s
          transaction.reference   = ''
          transaction.type        = TYPES[t.number] || t.number
          transaction.unique_id   = transaction.generate_unique_id

          add_transaction transaction
        end
      end

      private

      def qif_parser
        file.rewind
        @qif_parser ||= ::Qif::Reader.new(file)
      end
    end
  end
end
