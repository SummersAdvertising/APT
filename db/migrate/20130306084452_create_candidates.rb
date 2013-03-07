class CreateCandidates < ActiveRecord::Migration
  def change
    create_table :candidates do |t|
      t.string :title
      t.integer :vote_yes
      t.integer :vote_no
      t.integer :vote_total
      t.text :candidate_hash

      t.timestamps
    end
  end
end
