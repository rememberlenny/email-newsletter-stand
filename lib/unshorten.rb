module Unshorten
  class << self

    def unshorten(url, options = {})
		uri_str = URI.encode(url)
		uri = URI.parse(url) rescue nil
		return url if uri.nil?
	    result = Curl::Easy.http_get(uri_str) do |curl|
			curl.follow_location = false
	    end
	    if result && !result.nil? && result.header_str && !result.header_str.nil? && result.header_str.split('Location: ').count > 1
			return result.header_str.split('Location: ')[1].split(' ')[0]
		end
    end
    alias :'[]' :unshorten
  end
end
