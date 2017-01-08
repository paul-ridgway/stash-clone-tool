require 'spec_helper'

describe StashCloneTool::CloneLink do
  it 'extracts link and type' do
    clone_link = StashCloneTool::CloneLink.new('href' => 'http://git.example.com/repo1', 'name' => 'ssh')
    expect(clone_link.uri).to eq 'http://git.example.com/repo1'
    expect(clone_link.type).to eq :ssh
  end
end
