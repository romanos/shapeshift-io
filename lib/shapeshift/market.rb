module Shapeshift
  # Network Layer for API Rest client
  module MarketClient
    # url: shapeshift.io/rate/[pair]
    # method: GET
    # [pair] is any valid coin pair such as btc_ltc or ltc_btc
    def rate( pair )
      get("/rate/#{pair}")
    end

    # url: shapeshift.io/limit/[pair]
    # method: GET
    # [pair] is any valid coin pair such as btc_ltc or ltc_btc
    def limit( pair )
      get("/limit/#{pair}")
    end
 
    # url: shapeshift.io/marketinfo/[pair]
    # method: GET     
    # [pair] (OPTIONAL) is any valid coin pair such as btc_ltc or ltc_btc.
    # The pair is not required and if not specified will return an array of all market infos.
    def market_info( pair = nil )
      get("/marketinfo/#{pair}")
    end

    # url: shapeshift.io/recenttx/[max]
    # method: GET 
    # [max] is an optional maximum number of transactions to return.
    # If [max] is not specified this will return 5 transactions.
    # Also, [max] must be a number between 1 and 50 (inclusive).
    def recent_tx( max = 5 )
      # max = max.clamp( 1, 50 )  # Clamp only available in Ruby 2.4+
      max = [ 1, max, 50 ].sort[1]
      get("/recenttx/#{max}")
    end

    # url: shapeshift.io/txStat/[address]
    # method: GET
    # [address] is the deposit address to look up.
    def tx_stat( address )
      get("/txStat/#{address}")
    end

    # url: shapeshift.io/timeremaining/[address]
    # method: GET
    # [address] is the deposit address to look up.
    def time_remaining( address )
      address = encode( address )
      get("/timeremaining/#{address}")
    end

    # url: shapeshift.io/getcoins
    # method: GET
    def get_coins
      get("/getcoins")
    end

    # url: shapeshift.io/txbyapikey/[apiKey]
    # method: GET
    # [apiKey] is the affiliate's PRIVATE api key.
    def tx_by_apikey( api_key )
      get("/txbyapikey/#{api_key}")
    end

    # url: shapeshift.io/txbyaddress/[address]/[apiKey]
    # method: GET
    # [address] the address that output coin was sent to for the shift
    # [apiKey] is the affiliate's PRIVATE api key.
    def tx_by_address( address, api_key )
      address = encode( address )
      get("/txbyaddress/#{address}/#{api_key}")
    end

    # url: shapeshift.io/validateAddress/[address]/[coinSymbol]
    # method: GET
    # [address] the address that the user wishes to validate
    # [coinSymbol] the currency symbol of the coin
    def validate_address( address, symbol )
      get("/validateAddress/#{address}/#{symbol}")
    end


    private

      # Please note that if the address is a ripple address, 
      # it will include the "?dt=destTagNUM" appended on the end, 
      # and you will need to use the URIEncodeComponent() function on 
      # the address before sending it in as a param, to get a successful response.
      def encode( address )
        address = URI.encode_www_form_component( address ) if address =~ /\?dt\=/i
        return address
      end
      

  end
end