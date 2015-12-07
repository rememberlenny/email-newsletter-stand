class Links < ActiveRecord::Base
	belongs_to :email, touch: true
	after_create :prep_get_ograph

	def self.save_url email_id, url
		Links.create(email_id: email_id, url: url)
	end

	def self.prep_get_ograph 
		Links.delay.get_ograph self.id
	end

	def self.get_ograph link_id
		@link = Links.find link_id
		@link.original_url = @link.url
		ograph = OpenGraph.new(@link.url)
		uri = URI ograph.url
		@link.url = ograph.url
		@link.url_host = uri.host
		@link.url_path = uri.path
		@link.title = ograph.title 
		@link.linktype = ograph.type 
		@link.description = ograph.description 
		@link.save
	end
end

