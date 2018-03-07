# frozen_string_literal: true

module Initializers
  class Database < ::BaseService
    def call
      ActiveRecord::Base.logger = logger
      ActiveRecord::Base.establish_connection(configs[Environment.current])
    end

    private

    def logger
      Logger.new(File.open('./log/active_record.log', 'w+'))
    end

    def configs
      YAML::load(::ERB.new(configs_file).result).deep_symbolize_keys
    end

    def configs_file
      File.read('./config/database.yml')
    end
  end
end
