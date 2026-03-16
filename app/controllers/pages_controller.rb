class PagesController < ApplicationController
  # This only skips the filter if it has actually been defined
  skip_before_action :authenticate_user!, raise: false, only: [:top_page]

  def top_page
  end
end