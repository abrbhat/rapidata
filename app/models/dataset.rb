class Dataset < ActiveRecord::Base
  attr_accessible :department, :description, :link, :sector, :title, :items
  has_many :term_items, :dependent => :destroy
end
