class SongSearchForm
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_accessor :q, :code, :home_id

  def initialize(params, home_id)
    if params && params.has_key?(:q)
      self.q = params[:q]
    end
    if params && params.has_key?(:code)
      self.code = params[:code]
    end
    self.home_id = home_id
  end

  def search
    # 数字のみの場合は id とみなす
    return Song.kept.where(id: q.to_i, home_id: home_id) if q =~ /^[1-9][0-9]*$/

    songs = Song.arel_table
    result = Song.kept.where(songs[:words_for_search].matches("%#{q}%")).where(home_id: home_id)
    if code.present?
      result = result.where(songs[:code].eq(code))
    end
    result
  end

  private
  def persisted?; false end
end