![build status](https://travis-ci.org/paul-ridgway/stash-clone-tool.svg?branch=master "Build Status")

# Stash Clone Tool
Clones all repositories in all projects a user has access to from a stash server.

Simple to use, enter the stash url, username and password.

Feel free to contribute at https://github.com/paul-ridgway/stash-clone-tool.

# Usage
Install the stash clone tool:

    gem install stash-clone-tool

You can now clone all repositories in all the projects you have access to:

    $ stash-clone-tool -s http://stash.example.com -u stashuser -p letmein

Omit the password argument (-p) to enter your password via masked standard input.

