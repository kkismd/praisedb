class Book < ActiveRecord::Base
  belongs_to :book_name

  VERSION_JAPANESE = 1
  VERSION_ENGLISH  = 2
end
