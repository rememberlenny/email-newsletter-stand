module Unshorten
  class << self

  	def unshorten(url)
		@@cache = {}
      options = {
	      :max_level => 10,
	      :timeout => 2,
	      :short_hosts => false,
	      :short_urls => /^(?:https?:)?\/*[^\/]*\/*[^\/]*$/,
	      :follow_codes => [302, 301],
	      :use_cache => true,
	      :add_missing_http => true
	  }
      options.each { |k, v| (options[k] = v) unless options.has_key? k }

      follow(url, options)
    end

    alias :'[]' :unshorten

    private

    def expire_cache #:nodoc:
      @@cache = { }
    end

    def add_missing_http(url) #:nodoc:
      if url =~ /^https?:/i
        url
      else
        "http://#{url}"
      end
    end

    def follow(url, options, level = 0) #:nodoc:
      url = add_missing_http(url) if options[:add_missing_http]

      puts 'return @@cache[url] if @@cache[url]'
      return @@cache[url] if @@cache[url]
      puts 'return url if level >= 10'
      return url if level >= 10
      uri = URI.parse(url) rescue nil

      puts 'return url if uri.nil?'
      return url if uri.nil?

      http = Net::HTTP.new(uri.host, uri.port)
      http.open_timeout = options[:timeout]
      http.read_timeout = options[:timeout]
      http.use_ssl = true if uri.scheme == 'https'

      path = uri.path
      path = '/' if !path || path.empty?
      path += "?#{uri.query}" if uri.query
      response = http.request_head(path) rescue nil
      puts 'made it to responses'
      if !response.nil? && response.code.to_i == 404
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
      if response.is_a?(Net::HTTPRedirection) && options[:follow_codes].include?(response.code.to_i) && response['location'] then
        expire_cache if @@cache.size > 2000
        location = URI.encode(response['location'])
        location = (uri + location).to_s if location
        @@cache[url] = follow(location, options, level + 1)
      else
        url
      end
    end

    alias :'[]' :unshorten
  end
end
