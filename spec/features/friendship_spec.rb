require 'rails_helper'

RSpec.describe Friendship, type: :feature do
  describe 'user index page' do
    it 'send invite to another user and delete it' do
      visit new_user_registration_path
      fill_in 'Name', with: 'w'
      fill_in 'Email', with: 'w@ex.com'
      fill_in 'Password', with: '123456'
      fill_in 'Password confirmation', with: '123456'
      click_on 'commit'
      click_on 'Sign out'
      visit new_user_registration_path
      fill_in 'Name', with: '2'
      fill_in 'Email', with: '2@ex.com'
      fill_in 'Password', with: '123456'
      fill_in 'Password confirmation', with: '123456'
      click_on 'commit'
      visit users_path
      click_on 'Invite w'
      expect(page).to have_content('Friendship request was sented.')
      click_on 'delete request'
      expect(page).to have_content('Friendship was deleted.')
    end
    it 'send invite to another user and accept it' do
      visit new_user_registration_path
      fill_in 'Name', with: 'w'
      fill_in 'Email', with: 'w@ex.com'
      fill_in 'Password', with: '123456'
      fill_in 'Password confirmation', with: '123456'
      click_on 'commit'
      click_on 'Sign out'
      visit new_user_registration_path
      fill_in 'Name', with: '2'
      fill_in 'Email', with: '2@ex.com'
      fill_in 'Password', with: '123456'
      fill_in 'Password confirmation', with: '123456'
      click_on 'commit'
      visit users_path
      click_on 'Invite w'
      click_on 'Sign out'
      visit new_user_session_path
      fill_in 'Email', with: 'w@ex.com'
      fill_in 'Password', with: '123456'
      click_on 'commit'
      visit users_path
      click_on 'Accept'
      expect(page).to have_content('Friendship request was accepted.')
    end
  end
end
