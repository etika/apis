module DhhScoreChallenge
  module Api
    module Common
      require 'httpi'
      require_relative 'request_handler'
      class BaseClass
        include HTTPI

        def initialize(path:, request_handler: ::DhhScoreChallenge::Api::Common::RequestHandler.new)
          @path            = path
          @request_handler = request_handler
        end
      end
    end
  end
end
