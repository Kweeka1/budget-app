Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  # Categories
  get 'categories', to: "category#index", as: "categories"
  get 'categories/new', to: "category#new", as: "new_category"
  post 'categories/create', to: "category#create", as: "create_category"
  post 'categories/:category_id/destroy', to: "category#destroy", as: 'destroy_category'

  # Expenses
  get 'categories/:category_id/expenses', to: "expenses#index", as: 'expenses'
  get 'categories/:category_id/expenses/new', to: "expenses#new", as: 'new_expense'
  get 'categories/:category_id/expenses/:expense_id', to: "expenses#show", as: 'expense'
  post 'categories/:category_id/expenses/create', to: "expenses#create", as: 'create_expense'
  post 'categories/:category_id/expenses/:expense_id/destroy', to: "expenses#destroy", as: 'destroy_expense'
end
