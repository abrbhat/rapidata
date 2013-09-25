class TermItem < ActiveRecord::Base
  attr_accessible :dataset_id, :term_id, :dataset, :term, :priority
  belongs_to :term
  belongs_to :dataset
end
