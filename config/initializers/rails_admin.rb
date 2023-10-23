RailsAdmin.config do |config|
  config.asset_source = :sprockets
  config.parent_controller = 'ApplicationController'

  ### Popular gems integration

  config.authenticate_with do
    user_id = session[:user_id]
    user = User.find(user_id) if user_id
    unless user&.admin?
      flash[:alert] = "権限がありません"
      redirect_to main_app.root_path
    end
  end

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
