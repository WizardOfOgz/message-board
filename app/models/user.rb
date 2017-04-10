class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :description, length: { maximum: 4_096 }  # Do not allow the user to save HUGE amounts of data to a text column. This limit is completely artbitrary.
end
