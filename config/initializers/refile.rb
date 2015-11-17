# config/initializers/refile.rb
require "refile/s3"

aws = {
  access_key_id: ENV['ENS_AWS_ACCESS_KEY_ID'],
  secret_access_key: ENV['ENS_AWS_SECRET_ACCESS_KEY'],
  region: ENV['ENS_AWS_REGION'],
  bucket: ENV['ENS_AWS_BUCKET'],
}
Refile.cache = Refile::S3.new(prefix: "cache", **aws)
Refile.store = Refile::S3.new(prefix: "store", **aws)
