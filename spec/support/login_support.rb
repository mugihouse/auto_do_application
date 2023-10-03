module LoginSupport
  def login(model)
    allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return({user_id: model.user_id})
  end
end
