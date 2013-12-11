desc 'Start the application'
task :start do
  system "bundle exec puma config.ru"
end

desc 'Clean Emacs auto-save files'
task :clean do
  system 'find -type f -name \*~ | xargs rm'
end

desc 'Clean cached files'
task :clean_cache do
  system 'find public/ -type f | grep -E ".*\.[a-z0-9]{32,32}\..*" | xargs rm'
end
