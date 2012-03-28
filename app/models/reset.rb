class Reset < ActiveRecord::Base
	t.string :case_number
	t.datetime :date
	t.string :reason
end
