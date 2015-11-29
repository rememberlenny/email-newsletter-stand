require 'aws-sdk'
namespace :sitemap do
  desc 'Upload the sitemap files to S3'
  task upload_to_s3: :environment do
    s3 = Aws::S3::Client.new(
      access_key_id: ENV['ENS_AWS_ACCESS_KEY_ID'],
      secret_access_key: ENV['ENS_AWS_SECRET_ACCESS_KEY'],
      region: ENV['ENS_AWS_REGION'],
    )
    bucket = s3.list_buckets[ENV['ENS_AWS_BUCKET']]
    Dir.entries(File.join(Rails.root, "public", "sitemaps")).each do |file_name|
      next if ['.', '..'].include? file_name
      path = "sitemaps/#{file_name}"
      file = File.join(Rails.root, "public", "sitemaps", file_name)

      begin
        object = bucket.objects[path]
        object.write(file: file)
      rescue Exception => e
        raise e
      end
      puts "Saved #{file_name} to S3"
    end
  end
end
