class TermItem < ActiveRecord::Base
  attr_accessible :dataset_id, :term_id, :dataset
  belongs_to :term
  belongs_to :dataset
end
