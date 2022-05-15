Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/authors', to: 'authors#index'
  post '/authors', to: 'authors#create'
  get '/authors/new', to: 'authors#new'
  get '/authors/:id', to: 'authors#show'
  patch '/authors/:id', to: 'authors#update'
  get '/authors/:id/edit', to: 'authors#edit'
  get '/books', to: 'books#index'
  get '/books/:id', to: 'books#show'
  get '/authors/:author_id/books', to: 'author_books#index'
end
