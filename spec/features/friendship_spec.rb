require 'rails_helper'

RSpec.describe Friendship, type: :feature do
  describe 'user index page' do
    describe 'friendships' do 
      before do
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
      end
      context 'on sender side' do
        it '#create' do
          expect(page).to have_content('Friendship request was sented.')
        end
        it '#destroy' do
          click_on 'delete request'
          expect(page).to have_content('Friendship was deleted.')
        end
      end
      context 'on reciever side' do
        before do
          click_on 'Sign out'
          visit new_user_session_path
          fill_in 'Email', with: 'w@ex.com'
          fill_in 'Password', with: '123456'
          click_on 'commit'
          visit users_path
        end
        it '#destroy' do
          click_on 'Reject'
          expect(page).to have_content('Friendship was deleted.')
        end
        context 'accepting and unfriend' do
          before do
            click_on 'Accept'
          end
          it '#accept' do
            expect(page).to have_content('Friendship request was accepted.')
          end
          it '#destroy' do
            click_on 'Unfriend'
            expect(page).to have_content('Friendship was deleted.')
          end
        end
      end
    end
  end
end
