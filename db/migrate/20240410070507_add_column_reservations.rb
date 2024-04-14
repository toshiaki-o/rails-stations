class AddColumnReservations < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :theater_id, :integer, null: false, after: :date
  end
end
