class Email < ActiveRecord::Base
  validates :newsletter_id, presence: true
  after_create :refresh_sitemap
  after_create :check_for_welcome
  after_create :prep_remove_unsubscribe
  after_create :prep_remove_short_links
  include AlgoliaSearch

  algoliasearch do
    # associated index settings can be configured from here
  end

  extend FriendlyId
  friendly_id :subject, use: :slugged

  def self.unshorten unshortned_url
    url = Unshorten[unshortned_url]
    return url
  end

  def prep_remove_short_links
    Email.delay.remove_short_links self.id
  end

  def self.remove_short_links email_id
    @email = Email.find email_id
    if !@email.raw_html.nil?
      @html = Nokogiri::HTML(@email.raw_html)
      @html.css('a').each do |el|
        puts 'Changing ' + el['href'].to_s
        el['href'] = Unshorten[el['href']]
        puts 'to ' + el['href'].to_s
        puts '--'
      end

      raw_html = @html.to_html
      @email.raw_html = raw_html
      @email.save
    end
  end

  def self.remove_unsubscribe email_id
    @email = Email.find email_id
    @newsletter = Newsletter.find @email.newsletter_id
    if !@email.raw_html.nil?
      @html = Nokogiri::HTML(@email.raw_html)
      @html.css('a').each do |el|
        if el.text.downcase.include? "unsubscribe"
          el['href'] = ""
          el.content = ""
          puts 'Found unsubscribe'
          puts 'Saving change'
        end

        if el.text.downcase.include? "subscription preferences"
          el['href'] = ""
          el.content = ""
          puts 'Found subscription preferences'
          puts 'Saving change'
        end
        if el.text.downcase.include? "update preferences"
          el['href'] = ""
          el.content = ""
          puts 'Found update preferences'
          puts 'Saving change'
        end
        if el.text.downcase.include? "update subscription"
          el['href'] = ""
          el.content = ""
          puts 'Found update subscription'
          puts 'Saving change'
        end
        if el.parent.text.downcase.include? "unsubscribe"
          el.content = ""
          puts 'Found unsubscribe in parent'
          puts 'Saving change'
        end

        raw_html = @html.to_html
        raw_html = raw_html.gsub @newsletter.uid, 'yourfriendly'
        raw_html = raw_html.gsub '<html', '<div'
        raw_html = raw_html.gsub '<body', '<div'

        @email.raw_html = raw_html
        @email.save
      end
    end
  end

  def prep_remove_unsubscribe
    Email.delay.remove_unsubscribe self.id
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

