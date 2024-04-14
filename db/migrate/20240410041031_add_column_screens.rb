class AddColumnScreens < ActiveRecord::Migration[6.1]
  def change
    add_reference :screens, :theater, foreign_key: true
  end
end
