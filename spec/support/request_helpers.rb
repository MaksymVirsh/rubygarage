module Request
  module JsonHelpers
    def json_response
      @json_response ||= JSON.parse(response.body, symbolize_names: true)
    end
  end

  module HeadersHelpers
    def json_accept_headers
      format = Mime::JSON.to_s

      request.headers['Accept'] = format
      request.headers['Content-Type'] = format
    end
  end
end
