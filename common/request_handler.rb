module DhhScoreChallenge
  module Api
    module Common
      class RequestHandler
        BASE_URL = 'https://api.github.com'.freeze
        def get(path, options = {})
          params = { method: :get, path: path }.merge(options)
          build_request_args(params)
          process(:get, httpi_client)
        end

        private
        def httpi_client
          @httpi_client ||= HTTPI::Request.new
        end

        def build_request_args(params)
          httpi_client
          @httpi_client.url = BASE_URL + params[:path]
          @httpi_client.headers = {
                                    "User-Agent" => "etika"
                                  }
        end

        def process(http_method, request)
          HTTPI.request(http_method, request)
        end
      end
    end
  end
end
