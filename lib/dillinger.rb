require 'active_model'

require 'dillinger/version'
require 'dillinger/transaction'
require 'dillinger/parser/base'
require 'dillinger/parser/ofx'
require 'dillinger/parser/qif'
require 'dillinger/parser/westpac_csv'
require 'dillinger/parser/asb_tdv'
require 'dillinger/parser/asb_csv'

# = Dillinger
#
# Dillinger is a library for detecting and parsing bank statement formats in Ruby.
module Dillinger
  ##
  # Detects the statement format and returns an initialized parser.
  # If it can't detect the file format it returns false.
  #
  # ==== Example:
  #   # OFX file
  #   Dillinger.new(open("./path/to/statement.ofx"))
  #   # => #<Dillinger::Parser::Ofx ...>
  #
  #   # QIF file
  #   Dillinger.new(open("./path/to/statement.qif"))
  #   # => #<Dillinger::Parser::Qif ...>
  #
  #   # Unknown file
  #   Dillinger.new(open("./path/to/statement.php"))
  #   # => false
  def self.new(file)
    Parser.constants.each do |const|
      klass = Parser.const_get(const)
      return klass.new(file) if klass.test(file.dup)
    end

    false
  end
end
