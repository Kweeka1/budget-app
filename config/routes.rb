Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  # Categories
  get 'categories', to: "category#index", as: "categories"
  get 'categories/new', to: "category#new", as: "new_category"
  post 'categories/create', to: "category#create", as: "create_category"

  # Expenses
  get 'categories/:category_id/expenses', to: "expenses#index", as: 'expenses'
  get 'categories/:category_id/expenses/:expense_id', to: "expenses#show", as: 'expense'
end
