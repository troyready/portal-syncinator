Portal Syncinator [![Build Status](https://travis-ci.org/biola/portal-syncinator.svg)](https://travis-ci.org/biola/portal-syncinator) [![Code Climate](https://codeclimate.com/github/biola/portal-syncinator/badges/gpa.svg)](https://codeclimate.com/github/biola/portal-syncinator)
=================

Portal Syncinator is a temporary tool to put newly created accounts from [trogdir-api](https://github.com/biola/trogdir-api) into the Legacy Portal table.

Requirements
------------
- Ruby
- Redis server (for Sidekiq)
- Read access to login MySQL database
- [FreeTDS](http://www.freetds.org/)
- trogdir-api installation

Installation
------------
```bash
git clone git@github.com:biola/password-syncinator.git
cd password-syncinator
bundle install
cp config/settings.local.yml.example config/settings.local.yml
```

Configuration
-------------
- Edit `config/settings.local.yml` accordingly.

Running
-------

```ruby
sidekiq -r ./config/environment.rb
```

Console
-------
To launch a console, `cd` into the app directory and run `irb -r ./config/environment.rb`

Deployment
----------
```bash
blazing setup [target name in blazing.rb]
git push [target name in blazing.rb]
```
