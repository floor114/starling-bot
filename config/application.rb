# frozen_string_literal: true

require_relative 'boot'
require 'bionic'
Bundler.require(*Bionic.groups)

STDOUT.sync = true

class StarlingBot < Bionic::Application
  config.locale = :ua
end
