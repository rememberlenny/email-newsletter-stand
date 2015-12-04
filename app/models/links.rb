class Links < ActiveRecord::Base
	belongs_to :email

	def self.save_url email_id, url
		Links.create(email_id: email_id, url: url)
	end

	def self.get_ograph link_id
		@link = Links.find link_id
		ograph = OpenGraph.new(@link.url)

		@link.url = ograph.url
		@link.title = ograph.title 
		@link.linktype = ograph.type 
		@link.description = ograph.description 
		@link.save
	end
end

