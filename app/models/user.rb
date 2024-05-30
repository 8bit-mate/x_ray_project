class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :preference, dependent: :destroy

  def update_preference(preferences)
    preference.update(preferences)
  end

  def admin?
    role == "admin"
  end
end
