SitemapGenerator::Sitemap.default_host = "https://www.emailnewsletterstand.com"
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
s3 = Aws::S3::Resource.new(
  access_key_id: ENV['ENS_AWS_ACCESS_KEY_ID'],
  secret_access_key: ENV['ENS_AWS_SECRET_ACCESS_KEY'],
  region: ENV['ENS_AWS_REGION'],
)
Dir.entries(File.join(Rails.root, "public", "sitemaps")).each do |file_name|
  next if ['.', '..'].include? file_name
  path = "sitemaps/#{file_name}"
  object = s3.bucket(ENV['ENS_AWS_BUCKET']).object(path)
  file = File.join(Rails.root, "public", "sitemaps", file_name)

  begin
    object.upload_file(file)

  rescue Exception => e
    raise e
  end
  puts "Saved #{file_name} to S3"
end
