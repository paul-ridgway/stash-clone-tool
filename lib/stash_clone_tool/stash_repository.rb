require 'stash_clone_tool/clone_link'
module StashCloneTool
  class StashRepository
    include StashCloneTool
    attr_reader :name, :slug, :project

    def initialize(project, repo)
      @name = repo['name']
      @clone_links = repo['links']['clone'].map { |link| CloneLink.new(link) }
      @slug = repo['slug']
      @project = project
    end

    def clone_link(type)
      cl = @clone_links.select { |link| link.type == type }.first
      cl.uri
    end
  end
end
