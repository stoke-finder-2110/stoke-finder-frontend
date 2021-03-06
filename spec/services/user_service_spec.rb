require 'rails_helper'

RSpec.describe UserService do
  describe 'Methods' do
    it "#user_info", :vcr do

      response = UserService.user_info(1)

      expect(response).to be_a(Hash)

      user_data = response[:data]

      expect(user_data).to have_key(:id)
      expect(user_data[:id]).to be_an(String)

      expect(user_data[:attributes]).to have_key(:user_name)
      expect(user_data[:attributes][:user_name]).to be_an(String)

      expect(user_data[:attributes]).to have_key(:email)
      expect(user_data[:attributes][:email]).to be_an(String)

      expect(user_data[:attributes]).to have_key(:street_address)
      expect(user_data[:attributes][:street_address]).to be_an(String)

      expect(user_data[:attributes]).to have_key(:city)
      expect(user_data[:attributes][:city]).to be_an(String)

      expect(user_data[:attributes]).to have_key(:state)
      expect(user_data[:attributes][:state]).to be_an(String)

      expect(user_data[:attributes]).to have_key(:zipcode)
      expect(user_data[:attributes][:zipcode]).to be_an(String)

      expect(user_data[:attributes]).to have_key(:activity_preferences)
      expect(user_data[:attributes][:activity_preferences]).to be_an(String)

      expect(user_data[:attributes]).to have_key(:latitude)
      expect(user_data[:attributes][:latitude]).to be_an(Float)

      expect(user_data[:attributes]).to have_key(:longitude)
      expect(user_data[:attributes][:longitude]).to be_an(Float)
    end

    context '#login_user' do
      it 'returns user data', :vcr do
        visit "/register"

        user = Faker::Name.first_name

        expect(page).to have_content("Create a New Account")
         fill_in :user_name, with: "#{user}"
         fill_in :email, with: "#{user}@email.com"
         fill_in :password, with: 'password12345'
         fill_in :password_confirmation, with: 'password12345'
         fill_in :street_address, with: '1234 Main St'
         fill_in :city, with: 'Denver'
         fill_in :state, with: 'CO'
         fill_in :zipcode, with: '80220'

        within '#activity-100049' do #ACCESSIBLE SWIMMING
          check
        end

        within '#activity-100050' do #SOFTBALL
          check
        end

        click_button 'Submit'
        click_button 'Logout'

        user_name = "Bob_Barker"
        password = "123FakeStreet"
        user_data = {user: "#{user}", password: 'password12345'}

        response = UserFacade.login_user(user_data)

        expect(response).to be_a(Hash)
        user_data = response[:data]

        expect(user_data).to have_key(:id)
        expect(user_data[:id]).to be_an(String)

        expect(user_data[:attributes]).to have_key(:user_name)
        expect(user_data[:attributes][:user_name]).to be_an(String)

        expect(user_data[:attributes]).to have_key(:email)
        expect(user_data[:attributes][:email]).to be_an(String)

        expect(user_data[:attributes]).to have_key(:street_address)
        expect(user_data[:attributes][:street_address]).to be_an(String)

        expect(user_data[:attributes]).to have_key(:city)
        expect(user_data[:attributes][:city]).to be_an(String)

        expect(user_data[:attributes]).to have_key(:state)
        expect(user_data[:attributes][:state]).to be_an(String)

        expect(user_data[:attributes]).to have_key(:zipcode)
        expect(user_data[:attributes][:zipcode]).to be_an(String)

        expect(user_data[:attributes]).to have_key(:activity_preferences)
        expect(user_data[:attributes][:activity_preferences]).to be_an(String)
      end
    end

    context '::oauth_find' do
      it 'returns user data' do
        VCR.use_cassette('why-god-why') do
          auto_hash = "beardbikesandbeers@gmail.com"

          response = UserService.oauth_find(auto_hash)

          expect(response).to be_a(Hash)
          user_data = response[:data]

          expect(user_data).to have_key(:id)
          expect(user_data[:id]).to be_an(String)

          expect(user_data[:attributes]).to have_key(:user_name)
          expect(user_data[:attributes][:user_name]).to be_an(String)

          expect(user_data[:attributes]).to have_key(:email)
          expect(user_data[:attributes][:email]).to be_an(String)

          expect(user_data[:attributes]).to have_key(:street_address)
          expect(user_data[:attributes][:street_address]).to be_an(String)

          expect(user_data[:attributes]).to have_key(:city)
          expect(user_data[:attributes][:city]).to be_an(String)

          expect(user_data[:attributes]).to have_key(:state)
          expect(user_data[:attributes][:state]).to be_an(String)

          expect(user_data[:attributes]).to have_key(:zipcode)
          expect(user_data[:attributes][:zipcode]).to be_an(String)

          expect(user_data[:attributes]).to have_key(:activity_preferences)
          expect(user_data[:attributes][:activity_preferences]).to be_an(String)
        end
      end
    end
  end
end
