class VotesController < ApplicationController

	def make_vote
	
		@candidate = Candidate.find( params[ :candidate_id ] )
		
		if !@candidate.nil?	
				
			@remote_ip = request.env["HPPT_X_FORWARDED_FOR"]
		
			@vote = Vote.new
			
			@vote.vote_ip = @remote_id
			
			@vote.candidate_id =  params[ :candidate_id ]
			
			@vote.save
		
			respond_to do | format |
				format.html
			end
		
		end
		
	
	end

end
