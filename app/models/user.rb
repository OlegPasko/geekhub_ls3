# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  has_secure_password

  # validates_uniqueness_of :email
  # validates_format_of :email, { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: true

  has_many :posts, dependent: :destroy

  has_many :tags, through: :posts

  after_create :sent_confirmation_email

  ROLES = ['admin', 'manager', 'user'] # = %w(admin ...)


  def sent_confirmation_email
    #send email
  end

end
