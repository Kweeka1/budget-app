require 'rails_helper'

RSpec.describe 'login', type: :system do
  before do
    user = User.new(name: 'martin', email: 'martin@gmail.com', password: '123456', password_confirmation: '123456')
    user.skip_confirmation!
    user.save!
  end

  context 'User authentication' do
    it 'Un-authenticated user should be redirected to login page' do
      visit categories_path
      expect(page).to have_content('LOGIN')
    end

    it 'User should be able to login' do
      visit root_path
      find(:xpath, '/html/body/main/div/div[2]/a[1]').click
      within '#new_user' do
        fill_in 'Email', with: 'martin@gmail.com'
        fill_in 'Password', with: '123456'
      end
      click_button 'Log in'
      expect(page).to have_content 'Categories'
    end
  end
end
