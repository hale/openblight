class AddStatusToJudgements < ActiveRecord::Migration
  def change
    add_column :judgements, :status, :string
    add_column :judgements, :notes, :string
  end
end
