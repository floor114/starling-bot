# frozen_string_literal: true

class Lunch < ActiveRecord::Base
  serialize :members, Array
end
