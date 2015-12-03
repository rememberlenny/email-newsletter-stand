class Email < ActiveRecord::Base
  validates :newsletter_id, presence: true
  after_create :refresh_sitemap
  after_create :check_for_welcome
  include AlgoliaSearch

  extend FriendlyId
  friendly_id :subject, use: :slugged

  def self.remove_unsubscribe_tag
    html_doc = Nokogiri::HTML(self.raw_html)
  end


  def self.remove_subscribe
    Email.all.each do |email|
      @email = email
      @newsletter = Newsletter.find @email.newsletter_id
      if !@email.raw_html.nil? 
        @html = Nokogiri::HTML(@email.raw_html)
        @html.css('a').each do |el|
          if el.text.downcase.include? "unsubscribe"
            el.href = ""
            el.text = ""
          puts 'Found unsubscribe'
          puts 'Saving change'
          raw_html = @html.to_html
          raw_html = raw_html.gsub! @newsletter.uid, 'yourfriendly'
          raw_html = raw_html.gsub! '<html', '<div'
          raw_html = raw_html.gsub! '<body', '<div'
          @email.raw_html = raw_html
          @email.save
          end
        end
      end
    end
  end

  def check_for_welcome
    flagged = false
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
      'your subscription',
      'update profile',
      'confirm your',
    ]
    flags.each do |flag|
      if self.subject && self.subject.downcase.index(flag) != nil
        flagged = true;
      end
    end
    if flagged == true
      self.admin_email = true
      self.save
    end
  end

  def refresh_sitemap
    Sitemap.delay.refresh
  end

  def self.get_recent id, count
    return Email.where(newsletter_id: id).where.not(admin_email: true).limit(count).reverse
  end
end

