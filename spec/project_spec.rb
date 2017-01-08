require 'spec_helper'

describe StashCloneTool::Project do
  it 'extract name, key and repositories' do
    json = {
      'id' => 103,
      'key' => 'DATA',
      'links' => {
        'self' => [
          {
            'href' => 'http://git.example.com/projects/DATA'
          }
        ]
      },
      'name' => 'Data Store',
      'type' => 'NORMAL'
    }

    client = double('stash_api_client')
    expect(client).to receive('get_repositories')
    project = StashCloneTool::Project.new(client, json)
    expect(project.name).to eq 'Data Store'
    expect(project.key).to eq 'DATA'
  end
end
