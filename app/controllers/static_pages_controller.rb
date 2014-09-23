class StaticPagesController < ApplicationController
  def home
    redirect_to prices_path
  end
end