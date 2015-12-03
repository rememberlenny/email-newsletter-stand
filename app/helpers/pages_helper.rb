module PagesHelper

  def render_curated_row placement
    curation = Curation.where(placement: placement).first
    curation_post = []
    if !curation.nil?
      results = CuratedPost.where(curation_id: curation.id)
      results.each do |post|
        curation_post << Newsletter.friendly.find(post.newsletter_id)
      end
    end
    return curation_post
  end

  def render_recent_newsletters num
    @emails = Email.order('created_at DESC').limit(num)
    return @emails
  end
end
