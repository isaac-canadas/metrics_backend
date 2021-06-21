Rails.application.routes.draw do
  # GET /metrics/average_day
  get '/metrics/average_day', to: 'metrics#average_day'
  # GET /metrics/average_hour
  get '/metrics/average_hour', to: 'metrics#average_hour'
  # GET /metrics/average_minute
  get '/metrics/average_minute', to: 'metrics#average_minute'
  # GET /metrics
  get '/metrics', to: 'metrics#index'
  # POST /metrics
  post '/metrics', to: 'metrics#create'
  # PUT /metrics/:id
  put '/metrics/:id', to: 'metrics#update'
  # DELETE /metrics/:id
  delete '/metrics/:id', to: 'metrics#destroy'

  #resources :metrics
end
