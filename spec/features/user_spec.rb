require 'rails_helper'

RSpec.describe User, type: :feature do
  describe 'new user' do
    it 'require all fields for a new user' do
      visit new_user_registration_path
      fill_in 'Name', with: nil
      fill_in 'Email', with: nil
      fill_in 'Password', with: nil
      fill_in 'Password confirmation', with: nil
      click_on 'commit'
      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Email can't be blank")
      expect(page).to have_content("Password can't be blank")
    end
    it 'create new user' do
      visit new_user_registration_path
      fill_in 'Name', with: 'w'
      fill_in 'Email', with: 'w@ex.com'
      fill_in 'Password', with: '123456'
      fill_in 'Password confirmation', with: '123456'
      click_on 'commit'
      expect(page).to have_content('Welcome! You have signed up successfully.')
    end
  end
end
