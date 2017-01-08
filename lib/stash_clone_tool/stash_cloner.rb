# Stash Cloner
require 'colorize'
require 'git'
require 'multiblock'
require 'stash_clone_tool/stash_api_client'
require 'stash_clone_tool/stash_repository'
require 'stash_clone_tool/stash_exception'
module StashCloneTool
  class StashCloner
    include StashCloneTool

    def initialize(stash_url, username, password, directory)
      @stash = StashApiClient.new(stash_url, username, password)
      @directory = directory
    end

    def clone_stash(clone_options, exclude = [])
      wrapper = Multiblock.wrapper
      yield(wrapper)
      @stash.projects.each do |project|
        next if exclude.include?(project.key)
        project.repositories.each do |repository|
          folder = File.join(@directory, project.key, repository.slug)
          wrapper.call(:initialize_repository, repository, folder)
          if Dir.exist?(folder)
            wrapper.call(:failure, repository, 'Target already exists')
          else
            Git.clone(repository.clone_link(:ssh), folder, clone_options)
            wrapper.call(:success, repository)
          end
        end
      end
    end
  end
end
