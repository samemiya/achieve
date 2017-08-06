Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  # DIVE14_SNSログイン で編集
  # OAuth機能を使えるようにする
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  # get 'top/index'
  
  # get 'blogs' => 'blogs#index' 
  # get 'top/index'
   
  resources :blogs, only: [:index, :new, :create, :edit, :update, :destroy] do
    collection do
      post :confirm
    end
    
    # member do
    #   post :confirm
    # end
  end
  
  # get 'contacts/index'
  # resources :contacts, only: [:index, :new, :create]

  resources :contacts, only: [:new, :create] do
    collection do
      post :confirm
    end
  end
  
  root 'top#index'

  # DIVE11_メール送信 で編集
  # 開発環境だとメールを送れない
  # 発信したかどうかを確認するツールを利用できるようにする
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

# DIVE14_API基礎編２で編集
# APIの演習
# 課題でshow,editを追加
  resources :poems, only: [:index,:show,:edit] #この行を追記する

end
  
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
# end
