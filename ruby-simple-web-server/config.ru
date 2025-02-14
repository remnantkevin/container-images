# frozen_string_literal: true

require 'logger'
require 'roda'

class App < Roda
  plugin :common_logger, Logger.new($stdout)

  def logger = opts[:common_logger]

  route do |r|
    # GET /
    r.root do
      response.status = 200
      ''
    end

    # GET /liveness
    r.get 'liveness' do
      response.status = 200
      'OK'
    end

    # GET /echo/:message
    r.get 'echo', :message do |message|
      response.status = 200
      message
    end

    # GET /log/:message
    r.get 'log', :message do |message|
      response.status = 200
      logger.info(message)
      ''
    end
  end
end

run App.freeze.app
