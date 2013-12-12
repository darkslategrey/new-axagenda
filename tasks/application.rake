desc 'Start the application'
task :start do
  system "bundle exec puma config.ru"
end

desc 'Clean Emacs auto-save files'
task :clean, :dir do |t, args|
  system "find #{args.to_a.join(' ')} -maxdepth 2 -type f -name \\*~ | xargs rm"
end


desc 'Stop Guard'
task :stop_guard do
  system 'kill $(pidof guard puma)'
end

desc 'Start Guard'
task :guard do
  # guard_opts  = "-P puma --notify false --no-interactions "
  guard_opts  = "-P puma --notify false"
  # guard_opts += "--latency 1.5"
  system "guard start #{guard_opts}"
end

desc 'Clean cached files'
task :clean_cache do
  system 'find public/ -type f | grep -E ".*\.[a-z0-9]{32,32}\..*" | xargs rm'
end

desc 'Run pry console'
task :console do
  system "pry --no-pager -r './utils/console'"
end
