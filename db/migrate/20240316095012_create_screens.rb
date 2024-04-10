class CreateScreens < ActiveRecord::Migration[6.1]
  def change
    create_table :screens do |t|
      t.integer :name, null: false
      t.references :schedule, null: false
      t.date :date, null: false
    end
  end
end
