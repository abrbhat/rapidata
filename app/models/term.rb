class Term < ActiveRecord::Base
  attr_accessible :term, :term_items
  has_many :term_items
end
