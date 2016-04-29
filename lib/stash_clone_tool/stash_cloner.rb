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

    def clone_stash
      wrapper = Multiblock.wrapper
      yield(wrapper)
      @stash.projects.each do |project|
        project.repositories.each do |repository|
          folder = File.join(@directory, project.key, repository.slug)
          wrapper.call(:initialize_repository, repository, folder)
          clone_link = repository.clone_link(:ssh)
          if Dir.exists?(folder)
            wrapper.call(:failure, repository, 'Target already exists')
          else
            Git.clone(clone_link, folder)
            wrapper.call(:success, repository)
          end
        end
      end
    end

  end
end
