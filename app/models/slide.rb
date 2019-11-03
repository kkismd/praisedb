class Slide < ActiveRecord::Base
  include Discard::Model

  def pages
    normalize_eol(body.to_s).split(/\n{4,}/)
  end

  def outline
    pages.map{ |page| page.gsub(/\n.*/, '') }
  end

  def self.recents
    self.order('updated_at DESC').limit(10)
  end

  def normalize_eol(str)
    str.gsub(/\r\n/,"\n").gsub(/\r/, "\n")
  end
end
