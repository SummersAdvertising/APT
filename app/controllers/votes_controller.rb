class VotesController < ApplicationController

	def make_vote
		
		@candidate = Candidate.where( :title => params[ :candidate_title ] ).first
		
		if !cookies[ :voted_records ].nil?
			records = ActiveSupport::JSON.decode(cookies[ :voted_records ])
		else
			records = Array.new
		end
		
		isVoted = false
		
		catch :check_cookie do 
			records.each do | record |
				if record == @candidate.id
					
					isVoted = true					
					throw :check_cookie
				
					
				end
			end
		end
		
		if !isVoted do
		
			records.push( @candidate.id  )
			
			cookies[ :voted_records ] = { :value => ActiveSupport::JSON.encode(records), :expires => 1.day.from_now};
			
			@remote_ip = request.env["REMOTE_ADDR"]
			
			
			# find current 
			
			@vote = Vote.new
			
			@vote.vote_ip = @remote_ip
			@vote.candidate_id =  @candidate.id
			
			
			if params[ :vote_content ] === 'no' 
			
				@vote.vote_content = 'no'			
				@candidate.vote_to_no
			
			else
			
				@vote.vote_content = 'yes'
				@candidate.vote_to_yes
			
			end
			
			@vote.vote_content = ( params[ :vote_content ] === 'no' ? 'no' : 'yes' )
					
			@vote.save
			@candidate.save
			
			# Save current user to voted in cookie
			#cookies[ 'voted' + @candidate.id ] = { :value => true, :expires => 1.day.from_now }
		end
	
		respond_to do | format |
			format.html { redirect_to :controller => :candidates, :action => :chart_page, :candidate_title => @candidate.title }
		end
	
	end

end
