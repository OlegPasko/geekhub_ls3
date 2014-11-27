# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  body       :text
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#  image      :string(255)
#

class Post < ActiveRecord::Base
  validates_presence_of :title
  validates_uniqueness_of :title, scope: :user
  validates_length_of :title, {minimum: 3}
  validates_presence_of :body, if: lambda { |post| post.title.length > 10 }
  validates_presence_of :user
  # validates_presence_of :body, if: big_title
  #
  # def big_title
  #   self.title.length > 10
  # end
  belongs_to :user
  has_many :tags

  scope :admin_posts, -> { where(user_id: 1) }
  scope :by_date, -> { order(:created_at) }

  mount_uploader :image, PostImageUploader

  def is_big?
    self.body.length > 10
  end

end
