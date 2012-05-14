module AddressesHelper
  def progressbar(a)
    progress = {:bar => '0%', :class => "empty"}
    unless a.workflow_steps.nil?
      if a.foreclosures != [] || a.demolitions != [] || a.maintenances != []
        progress = {:bar => '100%', :arrow => '97%', :class => "full"}
      elsif a.judgements != []
        progress = {:bar => '80%', :arrow => '78%'}
      elsif a.hearings != []
        progress = {:bar => '60%', :arrow => '58%'}
      elsif a.notifications != []
        progress = {:bar => '40%', :arrow => '38%'}
      elsif a.inspections != []
        progress = {:bar => '20%', :arrow => '18%'}
      end
    end
    return progress
  end
end
