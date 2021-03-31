class HomeController < ApplicationController
  # def index
  #   if current_admin || current_user 
  #     redirect_to root_path
  #   end
  # end
  def index
    @products = Product.all

  end
end
