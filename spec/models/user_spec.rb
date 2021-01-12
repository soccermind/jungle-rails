require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    
    it "must be created with a password and password_confirmation fields" do
      @user = User.new({
        first_name: 'Penny',
        last_name: 'Pincher',
        email: 'ppincher@test.com',
        password: 'password',
        password_confirmation: 'password'
      })
      expect{@user.save!}.to change {User.count}
    end

    it "should not be created if password does not match password_confirmation" do
      @user = User.new({
        first_name: 'Penny',
        last_name: 'Pincher',
        email: 'ppincher@test.com',
        password: 'password',
        password_confirmation: 'motdepasse'
      })
      @user.validate
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "should not be created if password is missing" do
      @user = User.new({
        first_name: 'Penny',
        last_name: 'Pincher',
        email: 'ppincher@test.com',
        password: nil,
        password_confirmation: 'motdepasse'
      })
      @user.validate
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it "should not be created if email is not unique (not case sensitive)" do
      @user1 = User.new({
        first_name: 'Penny',
        last_name: 'Pincher',
        email: 'ppincher@test.com',
        password: 'password',
        password_confirmation: 'password'
      })
      @user1.save!
      
      @user2 = User.new({
        first_name: 'Peter',
        last_name: 'Pincher',
        email: 'PPINCHER@test.com',
        password: 'password',
        password_confirmation: 'password'
      })
      @user2.validate
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end

    it "should not be created if first name is missing" do
      @user = User.new({
        first_name: nil,
        last_name: 'Pincher',
        email: 'ppincher@test.com',
        password: 'password',
        password_confirmation: 'password'
      })
      @user.validate
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it "should not be created if last name is missing" do
      @user = User.new({
        first_name: 'Penny',
        last_name: nil,
        email: 'ppincher@test.com',
        password: 'password',
        password_confirmation: 'password'
      })
      @user.validate
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end
    
    it "should not be created if email is missing" do
      @user = User.new({
        first_name: 'Penny',
        last_name: 'Pincher',
        email: nil,
        password: 'password',
        password_confirmation: 'password'
      })
      @user.validate
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it "should not be created if password lenght is less than 6 characters" do
      @user = User.new({
        first_name: 'Penny',
        last_name: 'Pincher',
        email: nil,
        password: 'pass',
        password_confirmation: 'pass'
      })
      @user.validate
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
    
  end
end
