class AddDateToJudgements < ActiveRecord::Migration
  def change
    add_column :judgements, :judgement_date, :datetime

  end
end
