module StashCloneTool
  class CloneLink

    attr_reader :uri, :type

    def initialize(link)
      @uri = link['href']
      @type = link['name'].to_sym
    end

  end
end