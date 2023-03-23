require 'rails_helper'

RSpec.describe 'Expenses', type: :system do
  before do
    user = User.new(name: 'martin', email: 'martin@gmail.com', password: '123456', password_confirmation: '123456')
    user.skip_confirmation!
    user.save!
  end

  # rubocop:disable Metrics/BlockLength
  context 'Read/Create expenses' do
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

    it 'user should be able to see expenses' do
      visit expenses_path(Group.first)
      expect(page).to have_content('Expenses: $0')
    end

    it 'User should be able to add a new expense' do
      visit expenses_path(Group.first)
      click_link('ADD EXPENSE')
      within '#new_expense' do
        fill_in 'Name', with: 'Books'
        fill_in 'Amount', with: '36.99'
        select 'School', from: 'category'
      end
      click_button('ADD NEW EXPENSE')
      expect(page).to have_content 'Expenses: $36.99'
      expect(page).to have_content 'Books'
    end
  end
  # rubocop:enable Metrics/BlockLength

  context 'Delete expenses' do
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

      # create a new expense
      visit expenses_path(Group.first)
      click_link('ADD EXPENSE')
      within '#new_expense' do
        fill_in 'Name', with: 'Books'
        fill_in 'Amount', with: '36.99'
        select 'School', from: 'category'
      end
      click_button('ADD NEW EXPENSE')
    end

    it 'User should be able to delete expenses' do
      visit expenses_path(Group.first)
      find('.fa-circle-xmark').click
      expect(page).to have_content 'Expenses: $0'
      expect(page).not_to have_content 'Books'
    end
  end
end
