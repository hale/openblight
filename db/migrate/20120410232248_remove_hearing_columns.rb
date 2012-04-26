class RemoveHearingColumns < ActiveRecord::Migration
  def up
  	remove_column :hearings, :inspection_id
  	remove_column :hearings, :notice_id
  end

  def down
  	add_colunn :hearings, :inspection_id, :integer
  	add_column :hearings, :notice_id, :integer

  end
end
