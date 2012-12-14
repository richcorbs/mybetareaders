set :stages, %w(staging production)
require 'capistrano/ext/multistage'

set :application, "mybetareaders"

set :scm, :git
set :repository,  "ssh://git@173.255.255.118:222/home/git/mybetareaders"
set :branch, "master"
set :deploy_via, :remote_cache
set :scm_verbose, true
set :keep_releases, 5

set :domain, "173.255.255.118"

ssh_options[:paranoid] = false
ssh_options[:port] = 222
ssh_options[:keys] = %w(/Users/rich/.ssh/id_dsa)
default_run_options[:pty] = true

set :user, "rich"
set :use_sudo, false

role :app, domain
role :web, domain
role :db,  domain, :primary => true

task :update_config, :roles => [:app] do
  #run "cp -Rf #{shared}/config/* #{release_path}/config/."
end
after 'deploy:update_code', :update_config

task :update_links, :roles => [:app] do
  #run "mkdir #{deploy_to}/current/tmp"
  #run "ln -s #{shared}/projectfiles #{deploy_to}/current/tmp/projectfiles"
  #run "ln -s #{shared}/invoices #{deploy_to}/current/tmp/invoices"
  #run "ln -s #{shared}/samples #{deploy_to}/current/public/samples"
end

after 'deploy:create_symlink', :update_links
after "deploy", "deploy:cleanup"

namespace :deploy do
  set :shared_children, shared_children << 'tmp/sockets'

  desc "Start the application"
  task :start, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && RAILS_ENV=#{stage} bundle exec puma -b 'unix://#{shared_path}/sockets/puma.sock' -S #{shared_path}/sockets/puma.state --control 'unix://#{shared_path}/sockets/pumactl.sock' >> #{shared_path}/log/puma-#{stage}.log 2>&1 &", :pty => false
  end

  desc "Stop the application"
  task :stop, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && RAILS_ENV=#{stage} bundle exec pumactl -S #{shared_path}/sockets/puma.state stop"
  end

  desc "Restart the application"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && RAILS_ENV=#{stage} bundle exec pumactl -S #{shared_path}/sockets/puma.state restart"
  end

  desc "Status of the application"
  task :status, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && RAILS_ENV=#{stage} bundle exec pumactl -S #{shared_path}/sockets/puma.state stats"
  end

end
