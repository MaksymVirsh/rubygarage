require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do
  sign_in_user

  before(:each) { json_accept_headers }

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'uploads the file' do
        expect{
          post :create, attributes_for(:attachment)
        }.to change(Attachment, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      it 'does not upload the file' do
        expect{
          post :create, attributes_for(:invalid_attachment)
        }.to_not change(Attachment, :count)
      end
    end
  end
end
