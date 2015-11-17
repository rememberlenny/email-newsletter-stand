module PagesHelper

  def render_curated_row placement
    curation = Curation.where(placement: placement).first
    curation_post = []
    if !curation.nil?
      curation_post = CurationPost.where(curation_id: curation.id)
    end
    return curation_post
  end
end
