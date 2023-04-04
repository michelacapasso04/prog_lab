class LocationsController < ApplicationController
    before_action :authenticate_user!
    load_and_authorize_resource
    def index_admin
        if current_user.is_admin?
            @locat = Location.all
        else 
            redirect_to locations_path
        end
    end

    def index
        if current_user.is_owner?
            @location= current_user.my_locations
        elsif current_user.is_user?
            @location = Location.where(status: "accepted")
        else 
            @location = Location.all
        end
    end

    def new 
        @newLoc = Location.new
        authorize! :create, @newLoc, :message=>"You are not authorized to complete this action."
        @categories = Category.all
        @noCats = "Non ci sono categorie disponibili"
    end

    def show
        if current_user.is_admin? || current_user.is_owner?
            @location = Location.find(params[:id])
        else 
            @location = Location.where(status: "accepted", id: params[:id])[0]
        end
        
        @cats = []
        if @location != nil
            @location.categories.each do |c|
                @cats.append(Category.find(c.id))
            end
        end
    end 

    def create
        if  !Location.where(name: params[:locations][:name], name: params[:locations][:lat], name: params[:locations][:long] ).empty?
            render html: "Il locale che stai cercango di aggiungere gia' esiste"
            
        else 

            @client = OpenStreetMap::Client.new
            @loc = "#{params[:locations][:street]}/" << "/#{params[:locations][:city]}"
            @res=@client.search(q: @loc, format: 'json', addressdetails: '1', accept_language: 'it')
            @lat=@res[0]['lat']
            @long=@res[0]['lon']
        
            @newLoc = Location.new(params.require(:locations).permit(:name, :foto))
            authorize! :create, @newLoc, :message=>"You are not authorized to complete this action."
            @newLoc.lat=@lat
            @newLoc.long=@long
            @newLoc.street="#{params[:locations][:street]}, " << "#{params[:locations][:city]}"
            @newLoc.user= current_user
            @newLoc.update_attributes(status: "pending")
            @newLoc.user=current_user
            @array = params[:categ]
            if @array != nil
                @arr = []
                @array.each do |c|
                    @arr.append(Category.find(c))
                end
                @newLoc.categories = @arr
            end

            @newLoc.user = current_user
            
            @newLoc.save
            
            redirect_to locations_path  
         end
    end

    #Manca autenticazione admin
    #Devi passare un array che contiene l-id di location e l-id di category 
    #cosi lo cerchi dentro type e se non esiste la categoria indicata dentro type,  vuol dire 
    #che il locale indicato non gli appartiene e quindi aggiungi la tupla. 
    def edit   
        @update_loc = Location.find(params[:id])
        authorize! :update, @update_loc, :message=>"You are not authorized to complete this action."
        @cats = @update_loc.categories
        @categories = Category.all
        @status_array = ["accepted", "pending", "rejected"]
    end 

    #Manca autenticazione admin
    def destroy 
            id = params[:id]
            @location = Location.find(id) 
            authorize! :destroy, @location, :message=>"You are not authorized to complete this action."     
            @location.destroy
            redirect_to locations_path
    end

    #Manca autenticazione admin
    def update
        @update_loc = Location.where(id: params[:id]).first
        authorize! :update, @update_loc, :message=>"You are not authorized to complete this action."
        if current_user.is_admin?
            @update_loc.update_attributes(status: params[:status])
        else  
            @update_loc.update_attributes(name: params[:locations][:name], foto: params[:locations][:foto])
            @allCats = params[:categ]
            if @allCats != nil
                @tmp = []
                @allCats.each do |c|
                    @tmp.append(Category.find(c))
                end
                @update_loc.categories = @tmp
            end
        end  
        redirect_to location_path(@update_loc)
    end

    def accept
        @list = Location.where(status: "pending")
        @noList = "Non ci sono locali da accettare"
    end

    def accept_locations
        @list = Location.where(status: "pending")
        @accept = params[:accepted]
        if @list != nil 
            @list.each do |nl|
                @n = Location.find(nl.id)
                @n.update_attributes(status: "rejected")
                
            end
            if @accept != nil 
                @accept.each do |al|
                    @a = Location.find(al)
                    #render html: @a
                    @a[0].update_attributes(status: "accepted")
                end
            end
        end
        redirect_to locations_path
    end

    def addto_favloc
        if current_user.is_user?
            id = params[:id]
            @loc = Location.find(id)
            if(!current_user.locations.include?(@loc))
                current_user.locations << @loc
            end
        end
        redirect_to index_favloc_path
    end

    def deletefrom_favloc
        id = params[:id]
        @loc=Location.find(id)
        if(current_user.locations.include?(@loc))
            current_user.locations.delete(@loc)
        end
        redirect_to request.referrer
    end

    def index_favloc
        if current_user.is_user?
            @locations=current_user.locations
        else 
            redirect_to root_path
        end
    end

end
