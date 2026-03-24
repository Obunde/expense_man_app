app_dir = "/var/www/expense_man_app/current"
worker_processes 2
working_directory app_dir

listen "#{app_dir}/tmp/sockets/unicorn.sock", backlog: 64
timeout 30

pid "#{app_dir}/tmp/pids/unicorn.pid"

stderr_path "#{app_dir}/log/unicorn.stderr.log"
stdout_path "#{app_dir}/log/unicorn.stdout.log"

preload_app true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) && ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) && ActiveRecord::Base.establish_connection
end