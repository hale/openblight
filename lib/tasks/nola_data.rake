namespace :nola_data do
  desc "Load all Accela and spreadsheet data"
  task :load_blight_lists do
    Rake::Task["inspections:load"].invoke
    Rake::Task["hearings:load"].invoke
    Rake::Task["resets:load_multiples"].invoke
    Rake::Task["demolitions:load_socrata"].invoke
    Rake::Task["demolitions:load_fema"].invoke
    Rake::Task["demolitions:load_nora"].invoke
    Rake::Task["demolitions:load_nosd"].invoke
    Rake::Task["demolitions:match"].invoke
    Rake::Task["foreclosures:load"].invoke
    Rake::Task["foreclosures:match"].invoke
    Rake::Task["maintenances:load"].invoke
    Rake::Task["maintenances:match"].invoke
  end

  desc "Load all data including parcels and addresses" 
  task :load_all do
    Rake::Task["addresses:load"].invoke
    Rake::Task["streets:load"].invoke
    Rake::Task["parcels:load"].invoke

    Rake::Task["nola_data:load_blight_lists"]
  end

  desc "Delete all workflow data from database"
  task :drop do
    Rake::Tash["hearings:drop"].invoke
    Rake::Tash["demolitions:drop"].invoke
    Rake::Tash["foreclosures:drop"].invoke
    Rake::Tash["maintenances:drop"].invoke
  end
end
