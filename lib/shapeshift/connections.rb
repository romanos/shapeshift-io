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
      return parse( resp )
    rescue ShapeshiftError => e 
      puts e.message
    end

    # Make an HTTP POST request
    def post( url, options = {} )
      headers = merge_headers( options[:headers] || {} )
      body = options[:body]
      resp = self.class.post( url, { body: body.to_json, headers: headers } )
      return parse( resp )
    rescue ShapeshiftError => e 
      puts e.message
    end

    private 

      def parse( resp )
        if resp.code == 200
          body = resp.parsed_response

          # Received marketplace error from Shapeshift
          if    body.is_a?(Hash) && body.has_key?("error")
            raise ShapeshiftError.new( body["error"] )
          elsif body.is_a?(Hash) && body.has_key?("success")
            return body["success"]
          else
            return body
          end
        else          
          raise HTTPError
        end
      end

  end
end