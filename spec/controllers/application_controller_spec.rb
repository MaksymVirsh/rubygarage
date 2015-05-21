require 'rails_helper'

RSpec.describe 'Application Controller', type: :request do
  it 'returns response in json format when access denied' do
    get '/projects'
    expect(response.content_type.to_s).to eq('application/json')
  end
end

RSpec.describe ApplicationController, type: :controller do
  it 'overwriting the sign_out redirect path method' do
    path = controller.send(:after_sign_out_path_for, nil)
    expect(path).to eq(new_user_session_path)
  end
end
