SitemapGenerator::Sitemap.adapter = SitemapGenerator::S3Adapter.new(fog_provider: 'AWS',
                                     aws_access_key_id: ENV['ENS_AWS_ACCESS_KEY_ID'],
                                     aws_secret_access_key: ENV['ENS_AWS_SECRET_ACCESS_KEY'],
                                     fog_directory: ENV['ENS_AWS_BUCKET'],
                                     fog_region: ENV['ENS_AWS_REGION'])

SitemapGenerator::Sitemap.public_path = 'tmp/'
SitemapGenerator::Sitemap.adapter = SitemapGenerator::S3Adapter.new
SitemapGenerator::Sitemap.sitemaps_host = "http://#{ENV['ENS_AWS_BUCKET']}.s3.amazonaws.com/"
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'
SitemapGenerator::Sitemap.default_host = "https://www.emailnewsletterstand.com"

SitemapGenerator::Sitemap.create do

  add root_path,        :priority => 0.9, :changefreq => 'daily'
  add newsletters_path, :priority => 0.8, :changefreq => 'daily'
  add emails_path,      :priority => 0.7, :changefreq => 'daily'
  add about_path,       :priority => 0.7, :changefreq => 'daily'
  add contact_path,     :priority => 0.7, :changefreq => 'daily'

  Newsletter.find_each do |newsletter|
    add newsletter_path(newsletter), :lastmod => newsletter.updated_at
  end

  Email.find_each do |email|
    add email_path(email), :lastmod => email.updated_at
  end

end
