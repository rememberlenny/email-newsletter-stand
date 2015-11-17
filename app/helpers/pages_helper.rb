module PagesHelper

  def render_curated_row placement
    curation = Curation.where(placement: placement).first
    curation_post = []
    if !curation.nil?
      results = CuratedPost.where(curation_id: curation.id)
      results.each do |post|
        curation_post << Newsletter.find(post.newsletter_id)
      end
    end
    return curation_post
  end

  def render_recent_newsletters num
    newsletters = Newsletter.all
    return newsletters
  end
end
