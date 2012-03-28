class CreateJudgements < ActiveRecord::Migration
  def change
    create_table :judgements do |t|
    	t.string :case_number
      t.timestamps
    end
    add_foreign_key(:judgements, :cases, :column => :case_number)
  end
end
