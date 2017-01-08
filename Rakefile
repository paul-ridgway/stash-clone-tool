require 'bundler/gem_tasks'
require 'rubocop/rake_task'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

desc 'Run rubocop'
task :rubocop do
  RuboCop::RakeTask.new
end

task default: [:rubocop, :spec, :build]
