module LoginSupport
  def login(model)
    mock_session = ActionController::TestSession.new(user_id: model.user_id)
    allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(mock_session)
  end
end
