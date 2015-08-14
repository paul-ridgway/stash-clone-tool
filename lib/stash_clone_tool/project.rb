module StashCloneTool
  class Project

    attr_reader :name, :key, :repositories

    def initialize(client, json)
      @name = json['name']
      @key = json['key']
      @repositories = client.get_repositories(self)
    end
  end
end