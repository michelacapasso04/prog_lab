Canard::Abilities.for(:owner) do
  can [:show], Category
  cannot [:create,:delete,:update], Category
  can [:create, :show, :update, :destroy], Location
  cannot  [:accept, :accept_locations], Location
  cannot [:create,:show,:delete,:update], Gathering
end
