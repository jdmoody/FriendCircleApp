# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  author_id  :integer
#  body       :text
#  created_at :datetime
#  updated_at :datetime
#

class Post < ActiveRecord::Base
  belongs_to :author, class_name: "User"
  has_many :links
  has_many :post_shares
  has_many :friend_circles, through: :post_shares
end
