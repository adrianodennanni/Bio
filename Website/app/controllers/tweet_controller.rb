class TweetController < ApplicationController
  
  def create
    @twit = Tweet.find(params[:id_tweet])
    @user = User.find(@twit.id_user)
    if (params[:vote]=='up')
      increaseVoteUp
      # If dislike was selected and the session exist
      if (session[params[:id_tweet]] == 'select_down')
        decreaseVoteDown
      end
      
      session[params[:id_tweet]] = 'select_up'
    elsif (params[:vote]=='down')
      increaseVoteDown      
      # If like was selected and the session exist
      if (session[params[:id_tweet]] == 'select_up')
        decreaseVoteUp
      end
      
      # Saving session
      session[params[:id_tweet]] = 'select_down'
    elsif (params[:vote]=='unselectUp')
      decreaseVoteUp
      #Cleaning session
      session[params[:id_tweet]] = ''
    elsif (params[:vote]=='unselectDown')
      decreaseVoteDown
      #Cleaning session
      session[params[:id_tweet]] = ''
    end
    
    
    redirect_to :back
  end
  
  #Private functions - Only use by this controller
  private
  def increaseVoteUp
    up_tweet = @twit.up_votes + 1
    up_user = @user.up_votes + 1 
    @twit.update_attribute('up_votes', up_tweet)
    @user.update_attribute('up_votes', up_user)
  end
  
  private
  def increaseVoteDown
    down_tweet = @twit.down_votes + 1
    @twit.update_attribute('down_votes', down_tweet)
    down_user = @user.down_votes + 1
    @user.update_attribute('down_votes', down_user)
  end
  
  private
  def decreaseVoteUp
    up_tweet = @twit.up_votes - 1
    up_user = @user.up_votes - 1
    @twit.update_attribute('up_votes', up_tweet)
    @user.update_attribute('up_votes', up_user)
  end
  
  private
  def decreaseVoteDown
    down_tweet = @twit.down_votes - 1
    down_user = @user.down_votes - 1
    @twit.update_attribute('down_votes', down_tweet)
    @user.update_attribute('down_votes', down_user)
  end
  
end
