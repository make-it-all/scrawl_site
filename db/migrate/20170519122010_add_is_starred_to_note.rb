class AddIsStarredToNote < ActiveRecord::Migration[5.1]
  def change
    add_column :notes, :is_starred, :boolean, default: false
  end
end
