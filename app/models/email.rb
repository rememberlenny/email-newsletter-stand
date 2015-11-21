class Email < ActiveRecord::Base
  validates :newsletter_id, presence: true
end
