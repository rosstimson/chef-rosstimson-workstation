rosstimson-workstation Cookbook
===============================

This is my environment/role cookbook that I use to package up all
cookbooks I want to install on any of my workstations.

Create a Release / Artifact
---------------------------

I use [aktau/github-release][github-release] to create releases and upload
artefacts to Github.  Install with:

```
$ go get github.com/aktau/github-release
```

Remember to set a Github access token with:

```
export GITHUB_TOKEN=...
```

### Release Process

User Berkshelf to package up all cookbooks.

```
$ bundle exec berks package releases/v0.1.0.tgz
```

Tag the release in Git.

```
$ git tag v0.1.0 && git push --tags
```

Create the release.

```
github-release release \
  --user rosstimson \
  --repo chef-rosstimson-workstation \
  --tag v0.1.0 \
  --name "v0.1.0" \
  --description "Initial release."
```

Upload the artefact created by Berkshelf.

```
github-release upload \
  --user rosstimson \
  --repo chef-rosstimson-workstation \
  --tag v0.1.0 \
  --name "rosstimson-workstation.tgz" \
  --file releases/v0.1.0.tgz
```

Provision a Workstation
-----------------------

Install Chef (as root user)

```
$ sudo su -

$ curl -L https://www.opscode.com/chef/install.sh | bash
```

Prepare chef-client config (you only need to do this the first time)

```
$ mkdir ~/.setup

$ cat > ~/.setup/client.rb <<EOF
log_level :info
log_location STDOUT
file_cache_path = '~/.setup/cache'
cookbook_path = '~/.setup/cookbooks'
EOL
```

Grab the packaged up cookbooks

```
$ cd /tmp

$ wget https://github.com/rosstimson/chef-rosstimson-workstation/releases/download/v0.1.0/rosstimson-workstation.tgz

$ tar xzvf rosstimson-workstation.tgz -C ~/.setup && rm rosstimson-workstation.tgz
```

Chef run with `chef-client` in local mode (with `chef-zero`).

```
$ cd ~/.setup

$ chef-client -c ~/.setup/client.rb -z -o rosstimson-workstation
```

Development
-----------

* Source hosted at [GitHub][repo]
* Report issues/questions/feature requests on [GitHub Issues][issues]

License and Author
------------------

Author:: [Ross Timson][rosstimson]
<[ross@rosstimson.com](mailto:ross@rosstimson.com)>.

License:: Licensed under [WTFPL][wtfpl].


[rosstimson]:         https://rosstimson.com
[repo]:               https://github.com/rosstimson/chef-rosstimson-workstation
[issues]:             https://github.com/rosstimson/chef-rosstimson-workstation/issues
[wtfpl]:              http://www.wtfpl.net/
[github-release]:     https://github.com/aktau/github-release
