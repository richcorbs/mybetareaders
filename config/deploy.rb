set :stages, %w(staging production)
require 'capistrano/ext/multistage'
require 'puma/capistrano'

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

