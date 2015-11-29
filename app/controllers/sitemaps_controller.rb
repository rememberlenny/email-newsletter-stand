class SitemapsController < ApplicationController
  def sitemap
    redirect_to "https://s3.amazonaws.com/#{ ENV['ENS_AWS_BUCKET'] }/sitemaps/sitemap.xml.gz"
  end
end
