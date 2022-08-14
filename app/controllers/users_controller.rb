class UsersController < ApplicationController
  
  def new
    @user = User.new(name: 'don', password: 'pass', token: 'lkjklj', email: 'ljkl')
    @user.save!
    render 'new', user: @user
  end

  def login
  end

  def signup
  end

  def sign_up
  end

  def session
  end

  def create
    # binding.pry
  end

  private

  def user_params_valid?
  end

  def user_params
  end
end
