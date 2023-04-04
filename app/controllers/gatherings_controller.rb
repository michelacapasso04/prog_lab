class GatheringsController < ApplicationController

    before_action :authenticate_user!


    # lista delle uscite dell'utente
    def index 
        @gatherings = current_user.gatherings
        if !current_user.is_user?
            redirect_to root_path
        end
    end

    def create 
        @gathering=Gathering.new(date: params[:date])
        authorize! :create, @gathering, :message=>"You are not authorized to complete this action."
        params[:partecipants].each do |part|
            @gathering.users << User.find(part)
        end 
        @gathering.location = Location.find(params[:location])
        @gathering.save
        redirect_to gatherings_path
    end 

    def new
    end 

    # voglio mostare le info di una singola uscita
    def show  
        @gathering= Gathering.find(params[:id])
    end

    # modifica le informazioni di un'uscita
    def edit 
        @gathering = Gathering.find(params[:id])
        authorize! :update, @gathering, :message=>"You are not authorized to complete this action."
    end

    def update
        @location = Location.find(params[:location])
        @gathering=Gathering.find(params[:id])
        authorize! :update, @gathering, :message=>"You are not authorized to complete this action."
        @gathering.update_attributes!(date: params[:date])
        @gathering.update_attributes!(location: @location)
		redirect_to gathering_path(@gathering)
    end

    # elimina l'uscita con quell'id
    def destroy 
        id = params[:id]
        @gathering = Gathering.find(id)
        authorize! :destroy, @gathering, :message=>"You are not authorized to complete this action."
		@gathering.destroy
		redirect_to gatherings_path
    end 

#metodo che genera le location per un gathering da creare
    def generate_locations
        @matching_loc = []
        @partecipants = params[:partecipants]
        if(@partecipants&&params[:date])
            puts @partecipants[@partecipants.length] = current_user.id
            @matching_loc = Location.search_match(@partecipants)
            @date = params[:date]
        else
            if(!params[:date])
                 flash[:alert]="Should select the date"
            else 
                flash[:alert]="Should select at least one friend"
            end
            redirect_to new_gathering_path
        end
    end 

    def update_location
        @gathering = Gathering.find(params[:id])
        authorize! :update, @gathering, :message=>"You are not authorized to complete this action."
        if(params[:adduser])
            params[:adduser].each do |user|
                if(!(@gathering.users.include?(user)))
                    @gathering.users << User.find(user)
                end
            end
        end
        if(params[:deleteuser])
            params[:deleteuser].each do |user|
                @gathering.users.delete(User.find(user))
            end
        end
        index=0
        @partecipants=[]
        @gathering.users.each do |part|
            puts @partecipants[index] = part.id
            index+=1
        end
        if (@partecipants.length ==0 )
            destroy()
        else
            @locations = Location.all
            @matching_loc = search_match(@partecipants)
            @date =  params[:gathering][:date]
        end
    end

#metodo che dato un gruppo di utenti, seleziona tra i locali quelli che matchano con quegli utenti
    


end
