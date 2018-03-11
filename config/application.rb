# frozen_string_literal: true

require_relative 'boot'
require 'bionic'
Bundler.require(*Bionic.groups)

class StarlingBot < Bionic::Application
  config.locale = :ua
end
