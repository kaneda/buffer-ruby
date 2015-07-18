require 'rake'

task :console do
  require 'irb'
  require 'irb/completion'
  require 'buffer_app'
  ARGV.clear
  IRB.start
end

begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec)

  task :default => :spec
rescue LoadError
  # no rspec available
end
