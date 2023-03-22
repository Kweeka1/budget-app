require 'rails_helper'

RSpec.describe 'Categories', type: :system do
  before do
    user = User.new(name: 'martin', email: 'martin@gmail.com', password: '123456', password_confirmation: '123456')
    user.skip_confirmation!
    user.save!
  end

  context 'Read/Create categories' do
    before do
      visit root_path
      find(:xpath, '/html/body/main/div/div[2]/a[1]').click
      within '#new_user' do
        fill_in 'Email', with: 'martin@gmail.com'
        fill_in 'Password', with: '123456'
      end
      click_button 'Log in'
    end

    it 'user should be able to see his categories' do
      visit categories_path
      expect(page).to have_content('Categories')
    end

    it 'User should be able to add a new category' do
      visit categories_path
      find(:xpath, '/html/body/main/div/div[3]/a').click
      within '#new_category' do
        fill_in 'Name', with: 'School'
        fill_in 'Icon Url', with: 'https://img.freepik.com/free-vector/large-school-building-scene_1308-32058.jpg?w=300'
      end
      find(:xpath, '/html/body/main/div/form/div[2]/input').click
      expect(page).to have_content 'Categories'
      expect(page).to have_content 'School'
    end
  end

  context 'Delete categories' do
    before do
      # Login
      visit root_path
      find(:xpath, '/html/body/main/div/div[2]/a[1]').click
      within '#new_user' do
        fill_in 'Email', with: 'martin@gmail.com'
        fill_in 'Password', with: '123456'
      end
      click_button 'Log in'

      # create a new category
      visit categories_path
      find(:xpath, '/html/body/main/div/div[3]/a').click
      within '#new_category' do
        fill_in 'Name', with: 'School'
        fill_in 'Icon Url', with: 'https://img.freepik.com/free-vector/large-school-building-scene_1308-32058.jpg?w=300'
      end
      find(:xpath, '/html/body/main/div/form/div[2]/input').click
    end

    it 'User should be able to delete categories' do
      visit categories_path
      find('.fa-circle-xmark').click
      expect(page).to have_content 'Categories'
      expect(page).not_to have_content 'School'
    end
  end
end
