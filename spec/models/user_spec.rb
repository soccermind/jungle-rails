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

  describe '.authenticate_with_credentials' do
    # examples for this class method here
    it "should return user object when user credentials are authentic" do
      @user = User.new({
        first_name: 'Penny',
        last_name: 'Pincher',
        email: 'ppincher@test.com',
        password: 'password',
        password_confirmation: 'password'
      })
      @user.save!
      expect(User.authenticate_with_credentials(@user.email, @user.password)).to be_truthy
    end

    it "should return nil when password is invalid" do
      @user = User.new({
        first_name: 'Penny',
        last_name: 'Pincher',
        email: 'ppincher@test.com',
        password: 'password',
        password_confirmation: 'password'
      })
      @user.save!
      expect(User.authenticate_with_credentials(@user.email, 'motdepasse')).to be_nil
    end

    it "should return nil when email does not exists in database" do
      expect(User.authenticate_with_credentials('non-existent@test.com', 'password')).to be_nil
    end

    it "should return user object for authentic credentials when email contains leading and/or trailing spaces" do
      @user = User.new({
        first_name: 'Penny',
        last_name: 'Pincher',
        email: 'ppincher@test.com',
        password: 'password',
        password_confirmation: 'password'
      })
      @user.save!
      expect(User.authenticate_with_credentials('   ppincher@test.com  ', @user.password)).to be_truthy
    end

    it "should return user object for authentic credentials without matching email case" do
      @user = User.new({
        first_name: 'Penny',
        last_name: 'Pincher',
        email: 'pPincher@test.COM',
        password: 'password',
        password_confirmation: 'password'
      })
      @user.save!
      expect(User.authenticate_with_credentials('PpINCHEr@TEST.CoM', @user.password)).to be_truthy
    end

  end  
  
end
