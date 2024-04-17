class ChangeIndexReservations < ActiveRecord::Migration[6.1]
  def change
    remove_index :reservations, column: [:date, :schedule_id, :sheet_id]
    add_index :reservations, [:date, :schedule_id, :sheet_id, :theater_id], unique: true, name: 'index_date_and_schedule_id_and_sheet_id_and_theater_id'
  end
end
