module Unshorten
  class << self
    def unshorten(url, options = {})
		uri_str = URI.encode(url)
	    result = Curl::Easy.http_get(uri_str) do |curl|
	      curl.follow_location = false
	    end
	    return result.header_str.split('Location: ')[1].split(' ')[0]
    end
    alias :'[]' :unshorten
  end
end
