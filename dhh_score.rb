module DhhScoreChallenge
  module Api
    require_relative 'common/base_class'
    require 'json'
    class DhhScore < ::DhhScoreChallenge::Api::Common::BaseClass
      EVENTSCOREHASH = {
                         IssuesEvent: 7,
                         IssueCommentEvent:6,
                         PushEvent: 5,
                         PullRequestReviewCommentEvent: 4,
                         WatchEvent:3,
                         CreateEvent:2,
                         OtherEvent:1
                        }
      def initialize
        super(path: '/users/dhh/events/public')
      end

      def get_github_score
        begin
          response       = @request_handler.get(@path)
          puts "DHH's github score is", check_events(response)
        rescue =>e
          puts "Exception is", e
        end
      end

      private
      def check_events(dhh_api_result)
        api_response = JSON.parse(dhh_api_result.raw_body)
        api_response.inject(0) do | github_score,response |
          github_score += known_event_match(response) ? EVENTSCOREHASH[response['type']] : EVENTSCOREHASH[:OtherEvent]
        end
      end

      def known_event_match(response)
        EVENTSCOREHASH.keys.include?response['type']
      end
    end
    DhhScoreChallenge::Api::DhhScore.new.get_github_score
  end
end
