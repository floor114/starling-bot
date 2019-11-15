# frozen_string_literal: true

class Lunch < ActiveRecord::Base
  belongs_to :chat

  serialize :members, Array
end
