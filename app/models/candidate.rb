class Candidate < ActiveRecord::Base
  attr_accessible :candidate_hash, :title, :vote_no, :vote_total, :vote_yes
  
  before_save :default_value
  
  def default_value
  	
  	self.vote_no = self.vote_no.nil? ? 0 : self.vote_no
  	self.vote_yes = self.vote_yes.nil? ? 0 : self.vote_yes
  	self.vote_total = self.vote_total.nil? ? 0 : self.vote_total
  	
  end
  
  def vote_to_yes
  	self.vote_yes += 1
  	self.vote_total = self.vote_yes + self.vote_no
  end
  
  def vote_to_no
  	self.vote_no += 1
  	self.vote_total = self.vote_yes + self.vote_no
  end
  
  
end
