require 'acceptance_helper'

feature 'User sign in' do
  given(:user) { FactoryGirl.create(:user) }

  scenario 'Registered user try to sign in' do
    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'

    expect(current_path).to eq root_path
  end

  scenario 'Unegistered user try to sign in' do
    visit new_user_session_path

    fill_in 'Email', with: 'wrong@test.com'
    fill_in 'Password', with: '12345678'
    click_on 'Log in'

    expect(current_path).to eq new_user_session_path
  end
end
