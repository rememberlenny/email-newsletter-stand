require 'aws-sdk'
namespace :sitemap do
  desc 'Upload the sitemap files to S3'
  task upload_to_s3: :environment do
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
  end

  desc 'Create the sitemap, then upload it to S3 and ping the search engines'
  task create_upload_and_ping: :environment do
    Rake::Task["sitemap:create"].invoke
    Rake::Task["sitemap:upload_to_s3"].invoke
    SitemapGenerator::Sitemap.ping_search_engines('https://www.emailnewsletterstand.com/sitemap.xml.gz')
  end
end


