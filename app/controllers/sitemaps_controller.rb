class SitemapsController < ApplicationController
  skip_authorization_check
  skip_before_action :authenticate_user!

  def sitemap
    redirect_to "https://s3.amazonaws.com/#{ ENV['ENS_AWS_BUCKET'] }/sitemaps/sitemap.xml.gz"
  end
end
