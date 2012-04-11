class RemoveHearingResultFromHearings < ActiveRecord::Migration
  def up
    remove_column :hearings, :hearing_result
      end

  def down
    add_column :hearings, :hearing_result, :string
  end
end
