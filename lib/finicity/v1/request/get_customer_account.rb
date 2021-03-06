module Finicity::V1
  module Request
    class GetCustomerAccount
      include ::Finicity::Logger
      extend ::HTTPClient::IncludeClient
      include_http_client do |client|
        client.cookie_manager = nil
        client.proxy = ::Finicity.config.proxy_url
      end

      ##
      # Attributes
      #
      attr_accessor :customer_id,
        :account_id,
        :token

      ##
      # Instance Methods
      #
      def initialize(token, customer_id, account_id)
        @customer_id = customer_id
        @account_id = account_id
        @token = token
      end

      def get_customer_account
        http_client.get(url, nil, headers)
      end
      
      def get_all_accounts
        http_client.get(all_account_url, nil, headers)
      end

      def headers
        {
          'Finicity-App-Key' => ::Finicity.config.app_key,
          'Finicity-App-Token' => token
        }
      end
      
      def all_account_url
        ::URI.join(
          ::Finicity.config.base_url,
          'v1/',
          'customers/',
          "#{customer_id}/",
          'accounts/'
        )
      end

      def url
        ::URI.join(
          ::Finicity.config.base_url,
          'v1/',
          'customers/',
          "#{customer_id}/",
          'accounts/',
          "#{account_id}"
        )
      end
    end
  end
end
