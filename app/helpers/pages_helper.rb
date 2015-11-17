module PagesHelper

  def render_curated_row placement
    curation = Curation.where(placement: placement).first
    if !curation.nil?
      curation_posts = CurationPosts.where(curation_id: curation.id)
    else
      curation_posts = []
    end
    return curation_posts
  end
end
