desc 'Start the application'
task :start do
  system "bundle exec puma config.ru"
end