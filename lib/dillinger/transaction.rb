module Dillinger
  # = Dillinger::Transaction
  #
  # Dillinger::Transaction represents a generic bank transaction.
  class Transaction
    include ActiveModel::Model
    include ActiveModel::Serialization

    FIELDS = [:date, :amount, :payee, :description, :reference, :particulars, :type, :unique_id]

    attr_accessor *FIELDS

    def attributes
      Hash[FIELDS.map { |k| [k, send(k)] }]
    end

    ##
    # Generates and returns a unique identifier for the transaction.
    def generate_unique_id
      Digest::SHA256.hexdigest unique_id_elements.join
    end

    def unique_id_elements
      [
        date,
        amount.to_f,
        description,
        particulars,
        payee,
        reference
      ].map(&:to_s).map(&:downcase)
    end
  end
end
