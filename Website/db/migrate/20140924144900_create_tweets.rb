class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets, {id: false } do |t|

      t.column :id, :long_primary_key
      t.text :text
      t.text :img_url
      t.datetime :date_tweet
      t.float :latitude
      t.float :longitude
      t.text :full_address
      t.string :city
      t.string :country
      t.string :hashtag
      t.text :urls
      t.belongs_to :user
      t.integer :up_votes
      t.integer :down_votes
      t.integer :reports
    end
  end
end
