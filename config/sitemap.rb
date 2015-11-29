SitemapGenerator::Sitemap.default_host = "https://www.emailnewsletterstand.com"
SitemapGenerator::Sitemap.create_index = true
SitemapGenerator::Sitemap.public_path = 'public/sitemaps/'
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
