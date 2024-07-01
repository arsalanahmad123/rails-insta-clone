Rails.application.routes.draw do
  root 'pages#home'
  get '/instagram',to: "pages#insta", as: "insta"
  get 'instagram/profile/:id',to: "pages#profile", as: "profile"
  get 'instagram/editprofile',to: "pages#editprofile", as: "editprofile"
  patch 'instagram/update_bio',to: "pages#update_bio", as: "update_bio"
  patch 'instagram/update_avatar',to: "pages#update_avatar", as: "update_avatar"
  delete 'instagram/remove_avatar',to: "pages#remove_avatar", as: "remove_avatar"
  get 'users/sign_up',to: "registrations#new", as: "new_user"
  post 'users/sign_up',to: "registrations#create", as: "user"
  get 'users/sign_in',to: "sessions#new", as: "new_session"
  post 'users/sign_in',to: "sessions#create", as: "session"
  delete 'users/sign_out',to: "sessions#destroy", as: "destroy_session"
  
  get "instagram/editsection",to: "pages#edit_section", as: "editsection"
  patch "instagram/editsection",to: "pages#update_section", as: "update_section"
  get "instagram/professionl_account",to: "pages#professional_account",as: "professional_account"
  get "instagram/change_password",to: "pages#change_password",as: "change_password"
  patch "instagram/change_password",to: "pages#update_password",as: "update_password"

  get "instagram/newpost",to: "posts#new",as: "new_post"
  post "instagram/newpost",to: "posts#create",as: "create_post"
  delete "instagram/deletepost/:id",to: "posts#destroy",as: "delete_post"
  get "instagram/reels",to: "posts#reels",as: "reels"
  get "instagram/explore",to: "posts#explore",as: "explore"
  get "instagram/posts/:id",to: "posts#show",as: "show_post"

  post "instagram/reels/like/:id",to: "posts#like",as: "create_like"

  get "instagram/reels/comments/:id",to: "comments#new",as: "new_comment"
  post "instagram/reels/comments/:id",to: "comments#create",as: "create_comment"

  get "instagram/users/:id",to: "registrations#show",as: "show_user"

end
