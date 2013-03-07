class AddVoteContentToVotes < ActiveRecord::Migration
  def change
  	add_column :votes, :vote_content, :string
  end
end
