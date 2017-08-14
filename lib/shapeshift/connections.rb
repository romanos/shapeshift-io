module Shapeshift
  # Network Layer for API Rest client
  module Connection
    private

    def merge_headers(input = {})
      {
        'Content-Type'  => 'application/json',
        'Accept'        => 'application/json'
      }.merge( input )
    end

    # Make an HTTP GET request
    def get( url, options = {} )
      headers = merge_headers( options[:headers] || {} )
      resp = self.class.get( url, { headers: headers } )
    end

    # Make an HTTP POST request
    def post( url, options = {} )
      headers = merge_headers( options[:headers] || {} )
      body = options[:body]
      resp = self.class.get( url, { body: body.to_json, headers: headers } )
    end

  end
end