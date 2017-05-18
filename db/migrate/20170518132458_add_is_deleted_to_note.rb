class AddIsDeletedToNote < ActiveRecord::Migration[5.1]
  def change
    add_column :notes, :is_deleted, :boolean
  end
end
