def run_thing
	Email.all.each do |email|
		@email = email
		@newsletter = Newsletter.find @email.newsletter_id
		if @email.raw_html 
			@html = Nokogiri::HTML(@email.raw_html)
			@html.css('a').each do |el|
			  if el.text.downcase.include? "unsubscribe"
			    el.href = ""
			    el.text = ""
				puts 'Found unsubscribe'
				puts 'Saving change'
				raw_html = @html.to_html.gsub! @newsletter.uid, 'yourfriendly'
				raw_html = @html.to_html.gsub! '<html', '<div'
				raw_html = @html.to_html.gsub! '<body', '<div'
				@email.raw_html = raw_html
				@email.save
			  end
			end
		end
	end
end