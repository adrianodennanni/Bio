class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|


      t.string :username
      t.string :name
      t.text :profile_image
      t.text :profile_bio
      t.integer :num_followers
      t.integer :num_following
      t.integer :num_tweets
      t.string :profile_created_at
      t.string :location
      t.text :website
      t.integer :up_votes
      t.integer :down_votes
      t.integer :reports

    end
  end
end
