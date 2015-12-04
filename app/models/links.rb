class Links < ActiveRecord::Base
	belongs_to :email

	def self.save_url email_id, url
		Links.create(email_id: email_id, url: url)
	end
end
