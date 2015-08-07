# Stash Cloner
require 'net/http'
require 'json'
require 'colorize'
require 'stash_clone_tool/stash_exception'
module StashCloneTool
  class StashCloner

    def initialize(stash_url, username, password, directory)
      @stash_url = stash_url
      @username = username
      @password = password
      @directory = directory
    end

    def go
      get_projects['values'].each do |project|
        process_project(project)
      end
    end

    private

    def process_project(prj)
      puts "  - #{prj['name']}...".light_yellow
      project = request("/rest/api/1.0/projects/#{prj['key']}/repos")
      project['values'].each do |repo|
        process_repo(prj['key'], repo)
      end
    end

    def process_repo(project_key, repo)
      puts "    - #{repo['name']}...".light_yellow
      clone_links = repo['links']['clone']
      clone_link = clone_links.select { |l| l['name'] == 'ssh' }.first['href']
      folder = File.join(@directory, project_key, repo['slug'])
      git_command = "git clone #{clone_link} #{folder}"
      puts "        Cloning ".light_blue + clone_link.light_white + " to ".light_blue + folder.light_white
      if Dir.exists?(folder)
        puts "        Target already exists".light_red
      else
        puts "        #{git_command}".light_green
        puts
        system(git_command)
        puts
      end
    end

    def request(url)
      uri = URI("#{@stash_url}#{url}")
      req = Net::HTTP::Get.new(uri.to_s)
      req.basic_auth @username, @password
      response = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') do |http|
        http.request(req)
      end
      json = JSON.parse(response.body)
      if json['errors']
        error_msg = json['errors'].map { |e| e['message'] }.join('. ')
        raise StashException.new(error_msg)
      end
      json
    end

    def get_projects
      request('/rest/api/1.0/projects?limit=100')
    end

  end
end
