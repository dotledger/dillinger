require 'set'
require 'digest'

module Dillinger
  module Parser
    # = Dillinger::Parser::Base
    #
    # Dillinger::Parser::Base is the generic parser that others can inherit from.
    class Base
      attr_accessor :file, :transactions

      ##
      # self.test must be implmented by parser that inherit from Dillinger::Parser::Base.
      def self.test(_file)
        false
      end

      ##
      # parse must be implmented by parser that inherit from Dillinger::Parser::Base.
      def parse
        fail StandardError.new('parse has not been implemented.')
      end

      ##
      # All parsers are initilized with a file.
      def initialize(file)
        @file = file
        @transactions = Set.new
      end

      protected

      ##
      # Appends a transaction to the transaction set.
      def add_transaction(transaction)
        transactions << transaction
      end
    end
  end
end
