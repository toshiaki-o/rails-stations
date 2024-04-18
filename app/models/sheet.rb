class Sheet < ApplicationRecord
  has_many :reservations, dependent: :destroy

  class << self
    def number
      sheets = Sheet.all.index_by(&:id)
      sheets.transform_values { |sheet| "#{sheet.row}-#{sheet.column}" }
    end
  end
end
