class Candidate < ActiveRecord::Base
  attr_accessible :candidate_hash, :title, :vote_no, :vote_total, :vote_yes
end
