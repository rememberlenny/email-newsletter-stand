module PagesHelper

  def render_curated_row placement
    curation = Curation.where(placement: placement).first
    curation_posts = CurationPosts.where(curation_id: curation.id)
    return curation_posts
  end
end
