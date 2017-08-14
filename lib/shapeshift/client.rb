module Shapeshift
  class Client 
    include HTTParty
    base_uri "https://shapeshift.io"

    include Shapeshift::Connection
    include Shapeshift::MarketClient
    include Shapeshift::TransactionClient
    
    def initialize( headers = {} )
      @headers = {}
    end

  end
end