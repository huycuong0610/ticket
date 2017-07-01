class AddIsHotToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :is_hot, :boolean
  end
end
