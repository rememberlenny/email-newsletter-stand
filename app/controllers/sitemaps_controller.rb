class SitemapsController < ApplicationController
  skip_authorization_check
  skip_before_action :authenticate_user!

  def sitemap
    redirect_to "https://s3.amazonaws.com/#{ ENV['ENS_AWS_BUCKET'] }/sitemaps/sitemap.xml.gz"
  end
  def sitemap1
    redirect_to "https://s3.amazonaws.com/#{ ENV['ENS_AWS_BUCKET'] }/sitemaps/sitemap1.xml.gz"
  end
  def sitemap2
    redirect_to "https://s3.amazonaws.com/#{ ENV['ENS_AWS_BUCKET'] }/sitemaps/sitemap2.xml.gz"
  end
  def sitemap3
    redirect_to "https://s3.amazonaws.com/#{ ENV['ENS_AWS_BUCKET'] }/sitemaps/sitemap3.xml.gz"
  end
  def sitemap4
    redirect_to "https://s3.amazonaws.com/#{ ENV['ENS_AWS_BUCKET'] }/sitemaps/sitemap4.xml.gz"
  end
  def sitemap5
    redirect_to "https://s3.amazonaws.com/#{ ENV['ENS_AWS_BUCKET'] }/sitemaps/sitemap5.xml.gz"
  end
end
