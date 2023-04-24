Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    post "/robot/:robot_id/orders", to: "orders#order"
  end
end
  namespace :api do 
   post '/orders/:order_id/orders' to: "orders#order"
  end