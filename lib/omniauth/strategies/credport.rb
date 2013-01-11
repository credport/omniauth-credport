require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Credport < OmniAuth::Strategies::OAuth2
      
      option :name, :credport
      option :client_options, {:site => ENV['CREDPORT_BASE_URL'] || "https://www.credport.org"}

      uid{ raw_info['id'] }

      info do
        {
          :id => raw_info['info']
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/api/v1/me.json').parsed
      end
    end
  end
end