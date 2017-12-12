# frozen_string_literal: true

json.user do |json|
  json.call(@user, :id, :email, :username, :bio, :image)

  
  json.confirmed @user.confirmed?

end
