class CreateRanks < ActiveRecord::Migration[6.1]
  def change
    create_table :ranks do |t|
      t.date :date, null: false, comment: '日付'
      t.integer :number, null: false, comment: '順位'
      t.references :movie, null: false, comment: '映画'
      t.integer :number_of_reservations, null: false, comment: '予約件数'
      t.timestamps
    end
  end
end
