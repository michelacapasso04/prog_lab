Canard::Abilities.for(:user) do
  can [:read], Category
  cannot [:create, :destroy, :update], Category
  can [:addto_favloc, :deletefrom_favloc, :index_favloc, :read], Location
  cannot [:accept, :accept_locations, :create, :destroy, :update], Location
  can [:read,:create, :destroy, :update], Gathering
  #can [:create, :destroy, :update, :read], FavCategory
end
