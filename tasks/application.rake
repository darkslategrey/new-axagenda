desc 'Start the application'
task :start do
  system "bundle exec puma config.ru"
end

desc 'Clean Emacs auto-save files'
task :clean do
  system 'find -type f -name \*~ | xargs rm'
end
