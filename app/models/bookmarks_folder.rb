class BookmarksFolder < ActiveRecord::Base
  belongs_to :bookmark
  belongs_to :folder
end
