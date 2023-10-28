# coding: utf-8
class BookSearchForm
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_accessor :n, :c, :vf, :vt, :lang

  LANG_BOTH = 1
  LANG_JAPANESE = 2
  LANG_ENGLISH = 3
  LANG_BOTH_2017 = 4
  LANG_JAPANESE_2017 = 5

  def initialize(params)
    self.n = params[:n] if params
    self.c = params[:c] if params
    self.vf = params[:vf] if params
    self.vt = params[:vt] if params
    self.lang = params[:lang] if params
  end

  def search
    # パラメータが与えられていない場合は空を返す
    return []  if n.blank?

    t = Book.arel_table
    books = Book.where(:book_name_id => n, :chapter => c)
    books = search_lang(books, t, lang)
    books = search_verse(books, t, vf, vt)
    books
  end

  def title
    result = ''
    if self.n.present?
      book_name = BookName.where(id: self.n.to_i).first
      result << book_name.japanese + '/' + book_name.english
    end
    if self.c.present?
      result << ' ' << self.c
    end
    if self.vf.present?
      result << ':' << self.vf
    end
    if self.vt.present?
      result << '-' << self.vt
    end

    result.present? ? result : '聖句検索'
  end

  private

  def persisted?; false; end

  def search_lang(books, t, lang)
   case lang.to_i
   when LANG_BOTH
             books.where(t[:version].eq(1).or(t[:version].eq(2)))
                  .order(t[:chapter].asc, t[:verse].asc, t[:version].asc)
   when LANG_JAPANESE
             books.where(:version => 1)
                  .order(t[:chapter].asc, t[:verse].asc)
   when LANG_ENGLISH
             books.where(:version => 2)
                  .order(t[:chapter].asc, t[:verse].asc)
   when LANG_BOTH_2017
             books.where(t[:version].eq(3).or(t[:version].eq(2)))
                  .order(t[:chapter].asc, t[:verse].asc, t[:version].desc)
   when LANG_JAPANESE_2017
              books.where(:version => 3)
                  .order(t[:chapter].asc, t[:verse].asc)
   end
  end

  def search_verse(books, t, vf, vt)
    books = books.where(t[:verse].gteq(vf)) if vf.present?
    books = books.where(t[:verse].lteq(vt)) if vt.present?
    books
  end
end
