class CategoriesController < ApplicationController
    # :authenticate_user! ->  metodo di supporto fornito fornito da devise 
    before_action :authenticate_user!

    # lista di tutte le categorie
    def index # /categories
        @categories = Category.all
    end

    def create # /categories
        @category = Category.new(params.require(:categories).permit(:name))
        authorize! :create, @category, :message=>"You are not authorized to complete this action."
        @category.save
        redirect_to categories_path
    end 

    def new  # /categories/new
        @category = Category.new
        authorize! :create, @category, :message=>"You are not authorized to complete this action."

    end 

    # con la show voglio mostrare la lista di tutti i locali che hanno come proprietà quella categoria
    def show  # /categories/:id
        @current_category = Category.find(params[:id])
        @locs = @current_category.locations
    end

    def fav_categories 
        if current_user.is_user?

        else redirect_to root_path

        end
    end

    def create_fav_categories
        if current_user.is_user?
            @categ = params[:categ]
            if !current_user.is_user?
                @categ = nil
            end
            if @categ != nil
                @fav_cats = []
                @categ.each do |c|
                    @fav_cats.append(Category.find(c)[0])
                end  
                #authorize! :create_fav_categories, current_user.categories, :message=>"You are not authorized to complete this action."
                current_user.categories = @fav_cats
            else 
                flash[:alert]="Choose some favourite categories!!"
            end 
            current_user.save
            redirect_to fav_categories_path
        else 
            redirect_to root_path
        end
    end

    # modifica (da parte di chi?) una categoria id
    def edit  # /categories/:id/edit
        @category = Category.find(params[:id])
        authorize! :update, @category, :message=>"You are not authorized to complete this action."
    end

    # questo metodo viene chiamato dopo il metodo #
    # quando qualcuno modifica una categoria e vuole aggiornare le modifiche nel database 
    def update  # /categories/:id
        id = params[:id]
        @category = Category.find(id)
        authorize! :update, @category, :message=>"You are not authorized to complete this action."
        @category.update_attributes!(params[:category].permit(:name))
		redirect_to categories_path
    end

    # elimina la categoria id
    def destroy  # /categories/:id
        id = params[:id]
        @category = Category.find(id)
        authorize! :destroy, @category, :message=>"You are not authorized to complete this action."
		@category.destroy
		redirect_to categories_path
    end 

end
