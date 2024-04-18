class AddColumnUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :is_admin, :boolean, default: false, null: false, after: :remember_created_at
  end
end
