class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
#  devise :database_authenticatable, :registerable,
#         :recoverable, :rememberable, :validatable,
#         :omniauthable

  devise :database_authenticatable, :rememberable, :omniauthable

  has_many :loans

  def self.from_omniauth_slack(auth)
    where(slack_uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name

      if User.count < 4
        user.admin = true
      end

      user.temporarily_demoted = false
      user.save

      return user
    end
  end
end
