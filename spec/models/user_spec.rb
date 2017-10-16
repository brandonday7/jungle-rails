require 'rails_helper'

RSpec.describe User, type: :model do


  describe 'Validations' do


    ## PERFECT INPUT
    context 'given a valid input name, email, and password' do
      it 'returns true' do
        @user = User.new(
          first_name: 'Lord',
          last_name: 'Voldemort',
          email: 'harryP@gmail.com',
          password: 'ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad'
        )
        expect(@user.save()).to be true
      end
    end


    ## MISSING INPUTS
    context 'given an empty first name field' do
      it "returns error message 'First name not valid'" do
        @user = User.new(
          first_name: nil,
          last_name: 'Voldemort',
          email: 'harryP@gmail.com',
          password: 'ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad'
        )
        @user.save()
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
    end

    context 'given an empty lasst name field' do
      it "returns error message 'Last name not valid'" do
        @user = User.new(
          first_name: 'Lord',
          last_name: nil,
          email: 'harryP@gmail.com',
          password: 'ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad'
        )
        @user.save()
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
    end


    context 'given an empty email field' do
      it "returns error message 'Email not valid'" do
        @user = User.new(
          first_name: 'Lord',
          last_name: 'Voldemort',
          email: nil,
          password: 'ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad'
        )
        @user.save()
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
    end

    context 'given an empty password field' do
      it "returns error message 'Password not valid'" do
        @user = User.new(
          first_name: 'Lord',
          last_name: 'Voldemort',
          email: 'harryP@gmail.com',
          password: nil
        )
        @user.save()
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
    end


    ## EMAIL MUST BE UNIQUE
    context 'given an email already in the database' do
      it "returns an error message 'email already in user'" do
        @user1 = User.new(
          first_name: 'Lord',
          last_name: 'Voldemort',
          email: 'harryP@gmail.com',
          password: 'ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad'
        )
        @user2 = User.new(
          first_name: 'Severus',
          last_name: 'Snape',
          email: 'HarryP@GMAIL.com',
          password: 'cb8379ac2098aa165029e3938a51da0bcecfc008fd6795f401178647f96c5b34'
        )
        @user1.save()
        @user2.save()

        expect(@user2.errors.full_messages).to include("Email has already been taken")
      end
    end


    ## IMPROPER PASSWORD REQUIREMENTS
    context "password must have a minimum length of 3 characters" do
      it "returns an error message 'password too short" do
        @user1 = User.new(
          first_name: 'Harry Potter',
          last_name: 'Potter',
          email: 'harry_p@magic.com',
          password: 'ab'
        )
        @user1.save()
        puts @user1.errors.full_messages
        expect(@user1.errors.full_messages).to include("Password is too short (minimum is 3 characters)")
      end
    end
  end





  ## TEST AUTHENTICATION FUNCTION IN USER METHOD
  describe ".authenticate_with_credentials" do
    context "given a user in the database's correct email and password, returns user" do
      it "returns user" do
        @user1 = User.new(
          first_name: 'Harry Potter',
          last_name: 'Potter',
          email: 'harry_p@magic.com',
          password: 'abcd'
        )
        @user1.save()
        expect(User.authenticate_with_credentials(@user1.email, @user1.password)).not_to be nil
      end
    end

    context "given incorrect password, returns nil" do
      it "returns nil" do
        @user1 = User.new(
          first_name: 'Harry Potter',
          last_name: 'Potter',
          email: 'harry_p@magic.com',
          password: 'abcd'
        )
        @user1.save()
        expect(User.authenticate_with_credentials(@user1.email, '1234')).to be nil
      end
    end

    context "given unrecognized email, returns nil" do
      it "returns nil" do
        expect(User.authenticate_with_credentials('unkown_email@gmail.com', '1234')).to be nil
      end
    end

    ## EDGE CASES FOR CREDENTIAL AUTHENTICATION
    context "given spaces before or after the string, returns user (success)" do
      it "returns user" do
        @user1 = User.new(
          first_name: 'Harry Potter',
          last_name: 'Potter',
          email: 'harry_p@magic.com',
          password: 'abcd'
        )
        @user1.save()
        expect(User.authenticate_with_credentials("   #{@user1.email}  ", @user1.password)).not_to be nil
      end
    end


    context "given improper case-type in email, returns user (success)" do
      it "returns user" do
        @user1 = User.new(
          first_name: 'Harry Potter',
          last_name: 'Potter',
          email: 'harry_p@magic.com',
          password: 'abcd'
        )
        @user1.save()
        expect(User.authenticate_with_credentials("HArry_P@MAgiC.com", @user1.password)).not_to be nil
      end
    end



  end



end
