require "bundler/gem_tasks"
require 'spec/rake/spectask'

Spec::Rake::SpecTask.new(:spec) do |task|
  task.spec_files = FileList['spec/**/*_spec.rb']
end

task :default do
  Rake::Task['spec'].execute
end