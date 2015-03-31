# User
class User < ActiveRecord::Base
  has_many :authorizations
  has_many :projects

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  def self.find_for_oauth(auth)
    authorization = Authorization.where(provider: auth.provider,
                                        uid: auth.uid.to_s).first

    return authorization.user if authorization

    email = auth.info[:email]
    user = User.find_by_email(email)

    user.create_authorization(auth) if user
    user = create_new_authorization(auth, email) unless user

    user
  end

  def create_authorization(auth)
    authorizations.create(provider: auth.provider, uid: auth.uid)
  end

  def self.create_new_authorization(auth, email)
    password = Devise.friendly_token[0, 20]
    user = User.create!(email: email, password: password,
                        password_confirmation: password)

    user.create_authorization(auth)
    user
  end
end
