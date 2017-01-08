# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'stash_clone_tool/version'

Gem::Specification.new do |spec|
  spec.name          = 'stash-clone-tool'
  spec.version       = StashCloneTool::VERSION
  spec.authors       = ['Paul Ridgway', 'James Ridgway', 'Douglas Mills']
  spec.email         = ['paul@thefloow.com', 'james.ridgway@thefloow.com', 'douglas.mills@thefloow.com']

  spec.summary       = 'Tool for cloning all projects from a Stash server.'
  spec.description   = 'Tool for cloning all projects from a Stash server.'
  spec.homepage      = 'https://github.com/paul-ridgway/stash-clone-tool'

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.' unless spec.respond_to?(:metadata)

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'bin'
  spec.executables   = ['stash-clone-tool']
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'overcommit'
  spec.add_runtime_dependency 'colorize', '~> 0.7.7'
  spec.add_runtime_dependency 'highline', '~> 1.7', '>= 1.7.3'
  spec.add_runtime_dependency 'git', '~> 1.2', '>= 1.2.9.1'
  spec.add_runtime_dependency 'multiblock', '~> 0.2.1'
end
