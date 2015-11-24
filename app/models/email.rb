class Email < ActiveRecord::Base
  validates :newsletter_id, presence: true
  after_create :check_for_welcome

  def check_for_welcome
    subj = self.subject.downcase
    flags = [
      'for subscribing',
      'welcome!',
      'you for joining',
      'thanks for signing',
      'welcome to ',
      'please confirm',
      'subscription confirmed',
      'welcome to your',
      'email validation',
      'confirm your',
    ]
    flags.each do |flag|
      if subj.index(flag) != nil
        self.admin_email = true
        self.save
      end
    end
  end

  def self.get_recent id, count
    return Email.where(newsletter_id: id).where.not(admin_email: true).limit(count).reverse
  end
end

