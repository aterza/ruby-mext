require "bundler/gem_tasks"
require "rspec/core/rake_task"
require 'rdoc/task'
require 'ruby-mext'

RDoc::Task.new do |rdoc|
  rdoc.main = "README.md"
  rdoc.rdoc_files.include("README.md", "lib   /*.rb")
end

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

Dir.glob(File.expand_path(File.join('..', 'lib', 'tasks', '**', '*.rake'), __FILE__)).each { |f| load f }
