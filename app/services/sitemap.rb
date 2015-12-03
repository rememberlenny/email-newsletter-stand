class Sitemap
  def self.refresh
    SitemapGenerator::Interpreter.run(config_file:'config/sitemap.rb')
    SitemapGenerator::Sitemap.ping_search_engines
  end
end
