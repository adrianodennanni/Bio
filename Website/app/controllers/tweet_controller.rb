class TweetController < ApplicationController
  
  def create
    @twit = Tweet.find(params[:id_tweet])
    @user = User.find(@twit.id_user)
    if (params[:vote]=='up')
      up_tweet = @twit.up_votes + 1
      up_user = @user.up_votes + 1 
      @twit.update_attribute('up_votes', up_tweet)
      @user.update_attribute('up_votes', up_user)
      
      #If dislike was selected
      if (session[params[:id_tweet]] == 'select_down')
        down_tweet = @twit.down_votes - 1
        down_user = @user.down_votes - 1
        @twit.update_attribute('down_votes', down_tweet)
        @user.update_attribute('down_votes', down_user)
      end
      
      session[params[:id_tweet]] = 'select_up'
    elsif (params[:vote]=='down')
      
      down_tweet = @twit.down_votes + 1
      @twit.update_attribute('down_votes', down_tweet)
      down_user = @user.down_votes + 1
      @user.update_attribute('down_votes', down_user)
      #If like was selected
      if (session[params[:id_tweet]] == 'select_up')
        up_tweet = @twit.up_votes - 1
        up_user = @user.up_votes - 1
        @twit.update_attribute('up_votes', up_tweet)
        @user.update_attribute('up_votes', up_user)
      end
      
      session[params[:id_tweet]] = 'select_down'
    end
    
    
    redirect_to :back
  end
  
end
