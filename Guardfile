# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'puma', :quiet => false, :force_run => true, :port => 4001 do
  watch('Gemfile.lock')
  watch(%r{lib/\*.rb})
  watch(%r{models/*\.rb})
  watch('app.rb')
  # watch(%r{^config|lib|models/*|app\.rb})
end
