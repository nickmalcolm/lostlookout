set :application, "Madify"
set :repository,  "git@github.com:nickmalcolm/lostlookout.git"

set :scm, :git

set :deploy_to, lambda {"/home/#{user}/application"}
set :deploy_via, :remote_cache
set :use_sudo, false
set :user, "lostlookout"
set :rails_env, "production"
set :branch, "master"

ssh_options[:paranoid] = false
ssh_options[:forward_agent] = true
role :web, "lostlookout.southgatelabs.com"
role :app, "lostlookout.southgatelabs.com"
role :db,  "lostlookout.southgatelabs.com", :primary => true 

namespace :deploy do
  # Using Phusion Passenger
  task :stop do
    run "for service in /home/#{user}/service/* ; do sv down $service ; done "
  end

  task :start do
    run "for service in /home/#{user}/service/* ; do sv up $service ; done "
  end

  task :restart, :roles => [:app] do
    run "cd #{current_path} && RAILS_ENV=#{rails_env} rake thinking_sphinx:configure && touch tmp/restart.txt"
    run "for service in /home/#{user}/service/* ; do sv restart $service ; done "
  end

  task :symlink_configs do
    run %( cd #{release_path} &&
        ln -nfs #{shared_path}/downloads #{release_path}/downloads &&
        ln -nfs #{shared_path}/db/sphinx #{release_path}/db/sphinx 
      )
      #  &&
      # RAILS_ENV=#{rails_env} rake thinking_sphinx:configure
  end
  # task :bundle do
  #   run "cd #{release_path} && RAILS_ENV=#{rails_env} bundle install --deployment"
  # end

end

namespace :cron do
  task :install do
    #run "crontab #{current_path}/config/crontabs/#{rails_env}"
  end
end


after "deploy:restart" do
  # cron.install
end

require 'bundler/capistrano'

        require './config/boot'
        require 'hoptoad_notifier/capistrano'
