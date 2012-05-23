module StatisticHelpers

	def addresses
		{:total => Address.count}
	end

	def cases
		{:total => Case.count, :matched => Case.count(:conditions =>'address_id is not null'), :unmatched => Case.count(:conditions => 'address_id is null'), :percentageMatched => Case.count(:conditions => "address_id is not null").to_f / Case.count.to_f * 100}
	end

	def inspections
		{:total => Inspection.count, :matched => Inspection.count(:conditions =>'case_number is not null'), :unmatched => Inspection.count(:conditions => 'case_number is null'), :percentageMatched => Inspection.count(:conditions => "case_number is not null").to_f / Inspection.count.to_f * 100, :types => Inspection.count(group: :inspection_type), :results => Inspection.count(group: :result)}
	end

	def notifications
		{:total => Notification.count, :matched => Notification.count(:conditions =>'case_number is not null'), :unmatched => Notification.count(:conditions => 'case_number is null'), :percentageMatched => Notification.count(:conditions => "case_number is not null").to_f / Notification.count.to_f * 100, :types => Notification.count(group: :notification_type)}
	end

	def hearings
		{:total => Hearing.count, :matched => Hearing.count(:conditions =>'case_number is not null'), :unmatched => Hearing.count(:conditions => 'case_number is null'), :percentageMatched => Hearing.count(:conditions => "case_number is not null").to_f / Hearing.count.to_f * 100}#, :status => Hearing.count(group: :hearing_status)}
	end

	def resets
		{:total => Reset.count, :matched => Reset.count(:conditions =>'case_number is not null'), :unmatched => Reset.count(:conditions => 'case_number is null'), :percentageMatched => Reset.count(:conditions => "case_number is not null").to_f / Reset.count.to_f * 100}
	end

	def judgements
		{:total => Judgement.count, :matched => Judgement.count(:conditions =>'case_number is not null'), :unmatched => Judgement.count(:conditions => 'case_number is null'), :percentageMatched => Judgement.count(:conditions => "case_number is not null").to_f / Judgement.count.to_f * 100, :status => Judgement.count(group: :status)}
	end

	def maintenances
		{:total => Maintenance.count, :matched => Maintenance.count(:conditions =>'address_id is not null'), :unmatched => Maintenance.count(:conditions => 'address_id is null'), :percentageMatched => Maintenance.count(:conditions => "address_id is not null").to_f / Maintenance.count.to_f * 100, :program_names => Maintenance.count(group: :program_name), :status => Maintenance.count(group: :status)}
	end

	def foreclosures
		{:total => Foreclosure.count, :matched => Foreclosure.count(:conditions =>'address_id is not null'), :unmatched => Foreclosure.count(:conditions => 'address_id is null'), :percentageMatched => Foreclosure.count(:conditions => "address_id is not null").to_f / Foreclosure.count.to_f * 100}#, :status => Foreclosure.count(group: :status)}
	end

	def demolitions
		{:total => Demolition.count, :matched => Demolition.count(:conditions =>'address_id is not null'), :unmatched => Demolition.count(:conditions => 'address_id is null'), :percentageMatched => Demolition.count(:conditions => "address_id is not null").to_f / Demolition.count.to_f * 100}
	end

	def all
		{:addresses => addresses, :cases => cases, :inspections => notifications, :hearings => hearings, :resets => resets, :judgements => judgements, :maintenances => maintenances, :foreclosures => foreclosures, :demolitions => demolitions}
	end
end