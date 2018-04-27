# == Route Map
#
#                     Prefix Verb   URI Pattern                                             Controller#Action
#           new_user_session GET    /auth/sign_in(.:format)                                 devise/sessions#new
#               user_session POST   /auth/sign_in(.:format)                                 devise/sessions#create
#       destroy_user_session DELETE /auth/sign_out(.:format)                                devise/sessions#destroy
#              user_password POST   /auth/secret(.:format)                                  devise/passwords#create
#          new_user_password GET    /auth/secret/new(.:format)                              devise/passwords#new
#         edit_user_password GET    /auth/secret/edit(.:format)                             devise/passwords#edit
#                            PATCH  /auth/secret(.:format)                                  devise/passwords#update
#                            PUT    /auth/secret(.:format)                                  devise/passwords#update
#   cancel_user_registration GET    /auth/cancel(.:format)                                  devise/registrations#cancel
#          user_registration POST   /auth(.:format)                                         devise/registrations#create
#      new_user_registration GET    /auth/sign_up(.:format)                                 devise/registrations#new
#     edit_user_registration GET    /auth/edit(.:format)                                    devise/registrations#edit
#                            PATCH  /auth(.:format)                                         devise/registrations#update
#                            PUT    /auth(.:format)                                         devise/registrations#update
#                            DELETE /auth(.:format)                                         devise/registrations#destroy
#                auth_tokens DELETE /auth/tokens(.:format)                                  tokens#destroy {:format=>"json"}
#                            POST   /auth/tokens(.:format)                                  tokens#create {:format=>"json"}
#          auth_tokens_check GET    /auth/tokens/check(.:format)                            tokens#check {:format=>"json"}
#             link_providers GET    /link_providers(.:format)                               link_providers#index
#                            POST   /link_providers(.:format)                               link_providers#create
#          new_link_provider GET    /link_providers/new(.:format)                           link_providers#new
#         edit_link_provider GET    /link_providers/:id/edit(.:format)                      link_providers#edit
#              link_provider GET    /link_providers/:id(.:format)                           link_providers#show
#                            PATCH  /link_providers/:id(.:format)                           link_providers#update
#                            PUT    /link_providers/:id(.:format)                           link_providers#update
#                            DELETE /link_providers/:id(.:format)                           link_providers#destroy
#                    devices GET    /devices(.:format)                                      devices#index
#                            POST   /devices(.:format)                                      devices#create
#                 new_device GET    /devices/new(.:format)                                  devices#new
#                edit_device GET    /devices/:id/edit(.:format)                             devices#edit
#                     device GET    /devices/:id(.:format)                                  devices#show
#                            PATCH  /devices/:id(.:format)                                  devices#update
#                            PUT    /devices/:id(.:format)                                  devices#update
#                            DELETE /devices/:id(.:format)                                  devices#destroy
#              contact_types GET    /contact_types(.:format)                                contact_types#index
#                            POST   /contact_types(.:format)                                contact_types#create
#           new_contact_type GET    /contact_types/new(.:format)                            contact_types#new
#          edit_contact_type GET    /contact_types/:id/edit(.:format)                       contact_types#edit
#               contact_type GET    /contact_types/:id(.:format)                            contact_types#show
#                            PATCH  /contact_types/:id(.:format)                            contact_types#update
#                            PUT    /contact_types/:id(.:format)                            contact_types#update
#                            DELETE /contact_types/:id(.:format)                            contact_types#destroy
#             contact_phones GET    /contacts/:contact_id/phones(.:format)                  phones#index
#                            POST   /contacts/:contact_id/phones(.:format)                  phones#create
#          new_contact_phone GET    /contacts/:contact_id/phones/new(.:format)              phones#new
#         edit_contact_phone GET    /contacts/:contact_id/phones/:id/edit(.:format)         phones#edit
#              contact_phone GET    /contacts/:contact_id/phones/:id(.:format)              phones#show
#                            PATCH  /contacts/:contact_id/phones/:id(.:format)              phones#update
#                            PUT    /contacts/:contact_id/phones/:id(.:format)              phones#update
#                            DELETE /contacts/:contact_id/phones/:id(.:format)              phones#destroy
#             contact_photos GET    /contacts/:contact_id/photos(.:format)                  photos#index
#                            POST   /contacts/:contact_id/photos(.:format)                  photos#create
#          new_contact_photo GET    /contacts/:contact_id/photos/new(.:format)              photos#new
#         edit_contact_photo GET    /contacts/:contact_id/photos/:id/edit(.:format)         photos#edit
#              contact_photo GET    /contacts/:contact_id/photos/:id(.:format)              photos#show
#                            PATCH  /contacts/:contact_id/photos/:id(.:format)              photos#update
#                            PUT    /contacts/:contact_id/photos/:id(.:format)              photos#update
#                            DELETE /contacts/:contact_id/photos/:id(.:format)              photos#destroy
#     contact_external_links GET    /contacts/:contact_id/external_links(.:format)          external_links#index
#                            POST   /contacts/:contact_id/external_links(.:format)          external_links#create
#  new_contact_external_link GET    /contacts/:contact_id/external_links/new(.:format)      external_links#new
# edit_contact_external_link GET    /contacts/:contact_id/external_links/:id/edit(.:format) external_links#edit
#      contact_external_link GET    /contacts/:contact_id/external_links/:id(.:format)      external_links#show
#                            PATCH  /contacts/:contact_id/external_links/:id(.:format)      external_links#update
#                            PUT    /contacts/:contact_id/external_links/:id(.:format)      external_links#update
#                            DELETE /contacts/:contact_id/external_links/:id(.:format)      external_links#destroy
#                   contacts GET    /contacts(.:format)                                     contacts#index
#                            POST   /contacts(.:format)                                     contacts#create
#                new_contact GET    /contacts/new(.:format)                                 contacts#new
#               edit_contact GET    /contacts/:id/edit(.:format)                            contacts#edit
#                    contact GET    /contacts/:id(.:format)                                 contacts#show
#                            PATCH  /contacts/:id(.:format)                                 contacts#update
#                            PUT    /contacts/:id(.:format)                                 contacts#update
#                            DELETE /contacts/:id(.:format)                                 contacts#destroy
#    helpful_region_contacts GET    /regions/:region_id/contacts/helpful(.:format)          contacts#helpful
#            region_contacts GET    /regions/:region_id/contacts(.:format)                  contacts#index
#                            POST   /regions/:region_id/contacts(.:format)                  contacts#create
#         new_region_contact GET    /regions/:region_id/contacts/new(.:format)              contacts#new
#        edit_region_contact GET    /regions/:region_id/contacts/:id/edit(.:format)         contacts#edit
#             region_contact GET    /regions/:region_id/contacts/:id(.:format)              contacts#show
#                            PATCH  /regions/:region_id/contacts/:id(.:format)              contacts#update
#                            PUT    /regions/:region_id/contacts/:id(.:format)              contacts#update
#                            DELETE /regions/:region_id/contacts/:id(.:format)              contacts#destroy
#                    regions GET    /regions(.:format)                                      regions#index
#                            POST   /regions(.:format)                                      regions#create
#                 new_region GET    /regions/new(.:format)                                  regions#new
#                edit_region GET    /regions/:id/edit(.:format)                             regions#edit
#                     region GET    /regions/:id(.:format)                                  regions#show
#                            PATCH  /regions/:id(.:format)                                  regions#update
#                            PUT    /regions/:id(.:format)                                  regions#update
#                            DELETE /regions/:id(.:format)                                  regions#destroy
#                 ad_regions GET    /ads/:ad_id/regions(.:format)                           regions#index
#                            POST   /ads/:ad_id/regions(.:format)                           regions#create
#              new_ad_region GET    /ads/:ad_id/regions/new(.:format)                       regions#new
#             edit_ad_region GET    /ads/:ad_id/regions/:id/edit(.:format)                  regions#edit
#                  ad_region GET    /ads/:ad_id/regions/:id(.:format)                       regions#show
#                            PATCH  /ads/:ad_id/regions/:id(.:format)                       regions#update
#                            PUT    /ads/:ad_id/regions/:id(.:format)                       regions#update
#                            DELETE /ads/:ad_id/regions/:id(.:format)                       regions#destroy
#                  ad_photos GET    /ads/:ad_id/photos(.:format)                            photos#index
#                            POST   /ads/:ad_id/photos(.:format)                            photos#create
#               new_ad_photo GET    /ads/:ad_id/photos/new(.:format)                        photos#new
#              edit_ad_photo GET    /ads/:ad_id/photos/:id/edit(.:format)                   photos#edit
#                   ad_photo GET    /ads/:ad_id/photos/:id(.:format)                        photos#show
#                            PATCH  /ads/:ad_id/photos/:id(.:format)                        photos#update
#                            PUT    /ads/:ad_id/photos/:id(.:format)                        photos#update
#                            DELETE /ads/:ad_id/photos/:id(.:format)                        photos#destroy
#          ad_external_links GET    /ads/:ad_id/external_links(.:format)                    external_links#index
#                            POST   /ads/:ad_id/external_links(.:format)                    external_links#create
#       new_ad_external_link GET    /ads/:ad_id/external_links/new(.:format)                external_links#new
#      edit_ad_external_link GET    /ads/:ad_id/external_links/:id/edit(.:format)           external_links#edit
#           ad_external_link GET    /ads/:ad_id/external_links/:id(.:format)                external_links#show
#                            PATCH  /ads/:ad_id/external_links/:id(.:format)                external_links#update
#                            PUT    /ads/:ad_id/external_links/:id(.:format)                external_links#update
#                            DELETE /ads/:ad_id/external_links/:id(.:format)                external_links#destroy
#                        ads GET    /ads(.:format)                                          ads#index
#                            POST   /ads(.:format)                                          ads#create
#                     new_ad GET    /ads/new(.:format)                                      ads#new
#                    edit_ad GET    /ads/:id/edit(.:format)                                 ads#edit
#                         ad GET    /ads/:id(.:format)                                      ads#show
#                            PATCH  /ads/:id(.:format)                                      ads#update
#                            PUT    /ads/:id(.:format)                                      ads#update
#                            DELETE /ads/:id(.:format)                                      ads#destroy
#                       root GET    /                                                       regions#index
#                      users GET    /users(.:format)                                        users#index
#                            POST   /users(.:format)                                        users#create
#                   new_user GET    /users/new(.:format)                                    users#new
#                  edit_user GET    /users/:id/edit(.:format)                               users#edit
#                       user GET    /users/:id(.:format)                                    users#show
#                            PATCH  /users/:id(.:format)                                    users#update
#                            PUT    /users/:id(.:format)                                    users#update
#                            DELETE /users/:id(.:format)                                    users#destroy
#

Rails.application.routes.draw do


  devise_for :users, path: 'auth', path_names: { :password => 'secret', :confirmation => 'verification', :unlock => 'unblock' }

  devise_scope :user do

    constraints format: 'json' do

      # Acesso
      delete  'auth/tokens'        => 'tokens#destroy'
      post    'auth/tokens'        => 'tokens#create'
      get     'auth/tokens/check'  => 'tokens#check'

    end

    resources :link_providers

    resources :devices

    resources :contact_types

    concern :with_photos do |options|
      resources :photos, options
    end

    concern :with_external_links do |options|
      resources :external_links, options
    end

    resources :contacts, concerns: [:with_photos, :with_external_links] do
      resources :phones
    end

    resources :regions do
      resources :contacts do
        collection do
          get 'helpful'
          get 'import_csv'
          post 'import'
        end
      end

    end

    resources :ads, concerns: [:with_photos, :with_external_links] do
      resources :regions
    end

  end

  root to: 'regions#index'

  resources :users, except: [:index]

  get '/sync/regions' => 'syncs#regions'
  get '/sync/ads' => 'syncs#ads'
  get '/sync/contacts' => 'syncs#contacts'
end
