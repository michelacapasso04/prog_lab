Canard::Abilities.for(:admin) do
  can [:create, :read, :update, :destroy], Category
  can [:accept, :accept_locations, :create, :read, :update, :destroy], Location 
  cannot  [:addto_favloc, :deletefrom_favloc,]
  can [:create, :update, :show, :destroy], Gathering
end
