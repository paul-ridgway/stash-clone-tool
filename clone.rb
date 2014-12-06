#!/usr/bin/env ruby
require 'net/http'
require 'json'
require 'colorize'
require 'highline/import'

base_url  = ask("Stash URL: ") { |q| q.echo = true }
$username = ask("Username:  ") { |q| q.echo = true }
$password = ask("Password:  ") { |q| q.echo = "*" }

def request(url) 
	uri = URI(url)

	req = Net::HTTP::Get.new(uri)
	req.basic_auth $username, $password

	res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') {|http|
	  http.request(req)
	}
	JSON.parse(res.body)
end

puts 'Scanning projects...'.light_yellow

projects = request("#{base_url}/rest/api/1.0/projects?limit=100")

if projects['errors'] 
	puts projects['errors'].map{|e| e['message']}.join('. ')
	exit -1
end

projects['values'].each do |p|
	puts "  - #{p['name']}...".light_yellow
	project = request("#{base_url}/rest/api/1.0/projects/#{p['key']}/repos")
	project['values'].each do |r|
		puts "    - #{r['name']}...".light_yellow
		clone_links = r['links']['clone']
		clone_link = clone_links.select{|l| l['name'] == 'ssh'}.first['href']
		folder = "#{p['key']}/#{r['slug']}"
		git_command = "git clone #{clone_link} #{p['key']}/#{r['slug']}"
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
end
