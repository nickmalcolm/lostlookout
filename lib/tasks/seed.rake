namespace :db do
  desc "Load seed fixtures (from db/fixtures) into the current environment's database." 
  task :seed => :environment do
    require 'active_record/fixtures'
    Dir.glob(Rails.root + "db/fixtures/*.yml").each do |file|
      puts "Creating data from "+file
      Fixtures.create_fixtures('db/fixtures', File.basename(file, '.*'))
    end
  end
end