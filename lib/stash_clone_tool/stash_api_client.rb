require 'net/http'
require 'json'
require 'stash_clone_tool/project'
module StashCloneTool
  class StashApiClient
    include StashCloneTool

    def initialize(stash_url, username, password)
      @stash_url = stash_url
      @username = username
      @password = password
    end

    def projects
      request('/rest/api/1.0/projects?limit=100')['values'].map { |json| Project.new(self, json) }
    end

    def get_repositories(project)
      request("/rest/api/1.0/projects/#{project.key}/repos")['values'].map { |json| StashRepository.new(project, json) }
    end

    private

    def request(url)
      uri = URI("#{@stash_url}#{url}")
      req = Net::HTTP::Get.new(uri.to_s)
      req.basic_auth @username, @password
      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
        http.request(req)
      end
      json = JSON.parse(response.body)
      if json['errors']
        error_msg = json['errors'].map { |e| e['message'] }.join('. ')
        raise StashException, error_msg
      end
      json
    end
  end
end
