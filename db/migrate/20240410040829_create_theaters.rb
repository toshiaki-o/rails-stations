class CreateTheaters < ActiveRecord::Migration[6.1]
  def change
    create_table :theaters do |t|
      t.string :name, null: false, limit: 25, comment: "劇場名"
      t.timestamps
    end
  end
end
