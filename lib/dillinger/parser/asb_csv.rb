require 'csv'

module Dillinger
  module Parser
    class AsbCsv < Base
      HEADER_LINE = /Date,Unique Id,Tran Type,Cheque Number,Payee,Memo,Amount/

      TYPES = {
        'TFR OUT' => 'TRANSFER',
        'EFTPOS' => 'EFTPOS',
        'D/D' => 'DIRECTDEBIT',
        'D/C' => 'DIRECTCREDIT',
        'LOAN INT' => 'DEBIT',
        'LOAN PRIN' => 'DEBIT',
        'XFER' => 'TRANSFER',
        'POS' => 'EFTPOS',
        'DEPOSIT' => 'DEPOSIT',
        'DIRECTDEP' => 'DEPOSIT'
      }

      def self.test(file)
        file.rewind
        !HEADER_LINE.match(file.take(7).last).nil?
      rescue
        false
      end

      def parse
        file.rewind
        data = file.read.split("\n")
        data.delete("\r")
        6.times { data.delete_at(0) }
        CSV.parse(data.join("\n").strip, headers: true, converters: :numeric, header_converters: :symbol) do |row|
          transaction = Dillinger::Transaction.new
          transaction.amount      = row.field(:amount).to_f
          transaction.date        = Date.strptime(row.field(:date), '%Y/%m/%d')
          transaction.description = ''
          transaction.particulars = row.field(:memo)
          transaction.payee       = row.field(:payee)
          transaction.reference   = ''
          transaction.type        = TYPES[row.field(:tran_type)] || row.field(:tran_type)
          transaction.unique_id   = transaction.generate_unique_id

          add_transaction transaction
        end
      end
    end
  end
end
