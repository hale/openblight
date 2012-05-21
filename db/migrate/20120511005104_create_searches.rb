class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.text :term
      t.string :ip

      t.timestamps
    end
  end
end
