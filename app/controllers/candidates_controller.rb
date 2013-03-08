class CandidatesController < ApplicationController
	layout :special_layout
	
	def form
	end
	
	def vote_page
	
		@candidate = Candidate.where( :title => params[ :candidate_title ] ).first
		
		
		if !cookies[ :voted_records ].nil?
			records = ActiveSupport::JSON.decode(cookies[ :voted_records ])
		else
			records = Array.new
		end
		
		if @candidate.nil?
						
			# The candidate doesn't exists
			
			@candidate = Candidate.new
			@candidate.title = params[ :candidate_title ]
			
			@candidate.save
		
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
		
		respond_to do | format |
			if isVoted 
				format.html { redirect_to :action => 'chart_page', :candidate_title => Rack::Utils.escape( @candidate.title ) }
			else
				format.html { render 'vote' }
			end
			 
		end
			
	end
	
	def chart_page
		@candidate = Candidate.where( :title => params[ :candidate_title ] ).first
		
		
		respond_to do | format |
			format.html { render 'chart' }
		end
		
	end


  # GET /candidates
  # GET /candidates.json
  def index
    @candidates = Candidate.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @candidates }
    end
  end

  # GET /candidates/1
  # GET /candidates/1.json
  def show
    @candidate = Candidate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @candidate }
    end
  end

  # GET /candidates/new
  # GET /candidates/new.json
  def new
    @candidate = Candidate.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @candidate }
    end
  end

  # GET /candidates/1/edit
  def edit
    @candidate = Candidate.find(params[:id])
  end

  # POST /candidates
  # POST /candidates.json
  def create
    @candidate = Candidate.new(params[:candidate])

    respond_to do |format|
      if @candidate.save
        format.html { redirect_to @candidate, notice: 'Candidate was successfully created.' }
        format.json { render json: @candidate, status: :created, location: @candidate }
      else
        format.html { render action: "new" }
        format.json { render json: @candidate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /candidates/1
  # PUT /candidates/1.json
  def update
    @candidate = Candidate.find(params[:id])

    respond_to do |format|
      if @candidate.update_attributes(params[:candidate])
        format.html { redirect_to @candidate, notice: 'Candidate was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @candidate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /candidates/1
  # DELETE /candidates/1.json
  def destroy
    @candidate = Candidate.find(params[:id])
    @candidate.destroy

    respond_to do |format|
      format.html { redirect_to candidates_url }
      format.json { head :no_content }
    end
  end
  
private
	def special_layout
		
		case action_name
			when 'vote_page', 'chart_page', 'form'
				'simple'
			else
				'application' 
		end
		
	end
  
end
