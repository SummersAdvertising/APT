class Vote < ActiveRecord::Base
  attr_accessible :candidate_id, :vote_ip, :vote_result
end
