class Admin < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    %w[
      id
      email
      created_at
      updated_at
    ]
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
