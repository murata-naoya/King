class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def admin_signed_in?
    current_user.role == 'admin'
  end
end
