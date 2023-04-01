class SlideSearchForm
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_accessor :q, :home_id

  def initialize(params, home_id)
    if params && params.has_key?(:q)
      self.q = params[:q]
    end
    self.home_id = home_id
  end

  def search
    slides = Slide.arel_table
    Slide.kept.where(slides[:body].matches("%#{q}%")).where(home_id: home_id)
  end

  private def persisted?
    false
  end
end