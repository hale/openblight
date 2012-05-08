class AddNotesToResets < ActiveRecord::Migration
  def change
    add_column :resets, :notes, :string

  end
end
