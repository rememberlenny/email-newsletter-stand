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

  def recent_email item
    ee = Email.where(newsletter_id: item.id)
    return ee.last
  end

  def render_recent_newsletters num
    newsletters = []
    newsletter_ids = Email.order('created_at DESC').select(:newsletter_id).map(&:newsletter_id).uniq
    newsletter_ids.each do |id|
      newsletters << Newsletter.find(id)
    end
    return newsletters.slice(0, 7)
  end
end
