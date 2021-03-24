class GroupsController < ApplicationController
  def index
  end

  def add
    @user = User.find(current_user.id)
    @groups = @user.groups
    
  end

  def destroy 
    @group = Group.find(params[:id])
    @group.destroy
    
    respond_to do |format|
       format.html { redirect_to group_delete_url }
       format.json { head :no_content }
     
      format.js
     end
  end
  def show
    @group = Group.find(params[:id])
 end
  def addgroup
    @group = Group.new(group_params)
    respond_to do |format|
    if @group.save
      
      format.html { redirect_to @group, notice: 'group was successfully created.' }
   
      
      format.js
    
    else
      
    end
    
 end
end

 

 
 def removemember
 
  GroupsUser.delete_by(user_id: params[:id] ,group_id: params[:group])
  respond_to do |format|
     format.html { redirect_to group_delete_url }
     format.json { head :no_content }
   
    format.js
   end

 end

 def groupmember
  @group = Group.find(params[:id])
  respond_to do |format|
  
    format.json { head :no_content }
   format.js
  end
 end

 def addmember
  @msg ='';
  name = friend_params[:name ]
  if name.empty? 
      @msg = "friend name can not be empty" 
  else
    if friend = User.where(:full_name => friend_params[:name ]).first
      if relation = Friend.where(:users_id => friend_params[:user_id]).where(:friend_id => friend[:id]).first
        @groupUser = GroupsUser.new({"user_id"=> friend.id ,"group_id"=> friend_params[:group_id ] })
        if  @groupUser.save
          @member =User.where(:id => @groupUser.user_id).first
          @group = @groupUser.group_id
          else
             @msg = "you already have added this friend" 
          end
       
        
        
      else
        @msg ="you dont have this friend"
      end
    else
      @msg ='we canot found friend with this name'    
     end
  end

 end
 
 def group_params
   
     params.require(:group).permit(:name, :user_id)
 end

 def friend_params
   params.require(:friend).permit(:name , :user_id ,:group_id)
 end

end
