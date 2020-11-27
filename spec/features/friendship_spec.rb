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
      describe 'mutual friendships' do
        before do
          click_on 'Sign out'
          visit new_user_registration_path
          fill_in 'Name', with: '3'
          fill_in 'Email', with: '3@ex.com'
          fill_in 'Password', with: '123456'
          fill_in 'Password confirmation', with: '123456'
          click_on 'commit'
          visit users_path
          click_on 'Invite 2'
          click_on 'Sign out'
        end
        before do
          visit new_user_session_path
          fill_in 'Email', with: 'w@ex.com'
          fill_in 'Password', with: '123456'
          click_on 'commit'
          visit users_path
          click_on 'Accept'
          click_on 'Sign out'
          visit new_user_session_path
          fill_in 'Email', with: '2@ex.com'
          fill_in 'Password', with: '123456'
          click_on 'commit'
          visit users_path
          click_on 'Accept'
        end
        context 'not direct friends' do
          it 'user 1 can see user3 as mutual' do
            click_on 'Sign out'
            visit new_user_session_path
            fill_in 'Email', with: 'w@ex.com'
            fill_in 'Password', with: '123456'
            click_on 'commit'
            visit users_path
            expect(find('.mutual-users-list')).to have_content('Name: 3')
          end
          it 'user 3 can see user1 as mutual' do
            click_on 'Sign out'
            visit new_user_session_path
            fill_in 'Email', with: '3@ex.com'
            fill_in 'Password', with: '123456'
            click_on 'commit'
            visit users_path
            expect(find('.mutual-users-list')).to have_content('Name: w')
          end
        end
        context 'direct friends' do
          before do
            click_on 'Sign out'
            visit new_user_session_path
            fill_in 'Email', with: 'w@ex.com'
            fill_in 'Password', with: '123456'
            click_on 'commit'
            visit users_path
            find('.mutual-users-list').click_on 'Invite 3'
            click_on 'Sign out'
            visit new_user_session_path
            fill_in 'Email', with: '3@ex.com'
            fill_in 'Password', with: '123456'
            click_on 'commit'
            visit users_path
            find('.mutual-users-list').click_on 'Accept'
          end
          it 'user 1 can see user3 as mutual' do
            click_on 'Sign out'
            visit new_user_session_path
            fill_in 'Email', with: 'w@ex.com'
            fill_in 'Password', with: '123456'
            click_on 'commit'
            visit users_path
            expect(find('.mutual-users-list')).to have_content('Name: 3')
          end
          it 'user 3 can see user1 as mutual' do
            expect(find('.mutual-users-list')).to have_content('Name: w')
          end
        end
      end
    end
  end
end
