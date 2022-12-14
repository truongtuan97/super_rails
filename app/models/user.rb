class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # , :lockable, :timeoutable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :confirmable,
         :omniauthable, omniauth_providers: %i[google_oauth2 github]

  has_many :invitees, class_name: 'User', foreign_key: :invited_by_id
  has_many :posts, dependent: :restrict_with_error
  def self.from_omniauth(access_token)
    user = User.where(email: access_token.info.email).first

    # Uncomment the section below if you want users to be created if they don't exist
    user ||= User.create(email: access_token.info.email,
                         password: Devise.friendly_token[0, 20])

    user.provider = access_token.provider
    user.uid = access_token.uid
    user.name = access_token.info.name
    user.image = access_token.info.image
    user.skip_confirmation!
    user.save!

    user
  end

  def username
    if name?
      name
    else
      email
    end
  end
end
