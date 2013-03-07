class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.string :vote_ip
      t.integer :candidate_id

      t.timestamps
    end
  end
end