# frozen_string_literal: true

class Chat < ActiveRecord::Base
  self.inheritance_column = nil

  TYPES = %w(private group supergroup channel).freeze

  # def private?
  # def group?
  # def supergroup?
  # def channel?
  TYPES.each do |type|
    define_method "#{type}?" do
      self.type == type
    end
  end
end
