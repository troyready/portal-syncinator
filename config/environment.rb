require 'bundler'
Bundler.require :default, ENV['RACK_ENV'] || ENV['RAILS_ENV'] || :development

require './lib/portal_syncinator'
PortalSyncinator.initialize!
