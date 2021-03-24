class FriendsController < ApplicationController
    def add
        @user = User.find(current_user.id)
        @friends = @user.users
    end

    def addfriend

        @msg ='';
        email = friend_params[:email]
        if email.empty? 
            @msg = "friend email can not be empty" 
        else
            if friend = User.where(:email => friend_params[:email]).first
                if friend.id == current_user.id
                    @msg ='you can not add this friend'
                else
                    @friendUser = Friend.new({"friend_id"=> friend.id ,"users_id"=> friend_params[:user_id] })
                    if @friendUser.save
                    @friend = @friendUser 
                    else
                       @msg = "you already have this friend" 
                    end
                end 
               
            else
                @msg ='we canot found friend with this email'    
            end
        end

    end



    def friend_params
        params.require(:friend).permit(:email , :user_id )
    end

    def destroy 
        Friend.delete_by(users_id:current_user.id ,friend_id: params[:friend_id])


        
        
        respond_to do |format|
           format.html { redirect_to friend_delete_url }
           format.json { head :no_content }
         
          format.js
         end
      end

end
