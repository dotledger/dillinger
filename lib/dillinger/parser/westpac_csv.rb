require 'csv'

module Dillinger
  module Parser
    class WestpacCsv < Base
      TYPES = {
        'EFTPOS TRANSACTION' => 'EFTPOS',
        'ONLINE BANKING' => 'TRANSFER',
        'BILL PAYMENT' => 'DEBIT'
      }

      HEADER_LINE = /Date,Amount,Other Party,Description,Reference,Particulars,Analysis Code/

      def self.test(file)
        file.rewind
        !HEADER_LINE.match(file.readline).nil?
      rescue
        false
      end

      def parse
        file.rewind
        CSV.parse(file.read, headers: true, converters: :numeric, header_converters: :symbol) do |row|
          transaction = Dillinger::Transaction.new
          transaction.amount      = row.field(:amount).to_f
          transaction.date        = Date.parse(row.field(:date))
          transaction.description = row.field(:analysis_code)
          transaction.payee       = row.field(:other_party)
          transaction.reference   = row.field(:reference)
          transaction.type        = TYPES[row.field(:description)] || row.field(:description)
          transaction.unique_id   = transaction.generate_unique_id

          add_transaction transaction
        end
      end
    end
  end
end
