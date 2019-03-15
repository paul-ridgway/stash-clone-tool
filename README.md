[![Build Status](https://travis-ci.org/paul-ridgway/stash-clone-tool.svg?branch=master)](https://travis-ci.org/paul-ridgway/stash-clone-tool) 

# Stash Clone Tool
Clones all repositories in all projects a user has access to from a stash/bitbucket server.

Simple to use, enter the stash url, username and password.

Feel free to contribute at https://github.com/paul-ridgway/stash-clone-tool.

## Usage
Install the stash clone tool:

    gem install stash-clone-tool

You can now clone all repositories in all the projects you have access to:

    $ stash-clone-tool -s http://stash.example.com -u stashuser -p letmein

Omit the password argument (-p) to enter your password via masked standard input.

## Development
stash-clone-tool uses rubocop and overcommit to ensure build quality.

To enable overcommit:

    $ overcommit && overcommit --sign
    
To check code style:

    $ bundle exec rubocop

The project can be build (which also runs rubocop), using:

    $ bundle exec rake
