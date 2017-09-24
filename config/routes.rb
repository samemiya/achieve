Rails.application.routes.draw do

  # DIVE15_コメント機能 で編集　
  # rails g コマンドで作成されるが不要なので削除する
  # get 'comments/create'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  # get 'top/index'
  
  # get 'blogs' => 'blogs#index' 
  # get 'top/index'
   
# DIVE15_コメント機能 で編集　
# resourcesの書き方を変える為に下記は削除
#   resources :blogs, only: [:index, :new, :create, :edit, :update, :destroy] do
#     collection do
#       post :confirm
#     end
    
#     # member do
#     #   post :confirm
#     # end
#   end

# DIVE15_コメント機能 で編集　新たに書き換えたもの
  resources :blogs do
    resources :comments
    post :confirm, on: :collection
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

  # DIVE14_API基礎編２ で編集
  # APIの演習
  # 課題でshow,editを追加
  resources :poems, only: [:index,:show,:edit] #この行を追記する
  
  # DIVE14_SNSログイン で編集
  # 新規登録する際に、継承したregistration_controllerが
  # 使用されるようにする
  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }

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
