class UsersController < ApplicationController
    before_action :authenticate_user!, except: [:new, :create]
    def show
    end

    def edit
    end

    def update
        new_user=current_user.update(params.require(:user).permit(:name,:email,:avatar))
        redirect_to root_path
    end

    def index_friends
        @friends=current_user.friends
    end

    def index_users
        @users= User.where.not(id: current_user.friends) #TODO fai vedere solo quelli con ruolo user
    end
    
    def add_friend
        new_friend=User.find(params[:id])
        if(!current_user.friends.include? new_friend)
            current_user.friends<<new_friend
            new_friend.friends<<current_user
            redirect_to user_friends_path
        else
            redirect_to user_all_path
        end
    end

    def remove_friend
        rem_friend=User.find(params[:id])
        if(current_user.friends.include? rem_friend)
            current_user.friends.delete(rem_friend)
            rem_friend.friends.delete(current_user)
        end
        redirect_to user_friends_path
    end

    def destroy
        curr_user_id=current_user.id
        id_rmv=params[:id]
        User.destroy(id_rmv)
        if (id_rmv==curr_user_id)
            redirect_to root_path
        else
            redirect_to users_all_path
        end
    end

    

end
