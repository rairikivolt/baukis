class Admin::TopController < Admin::Base
  skip_before_actio :authorize

  def index
    if current_administrator
      render action: 'dashboard'
    else
      render action: 'index'
    end
  end
end
