# == Schema Information
#
# Table name: friend_circles
#
#  id         :integer          not null, primary key
#  owner_id   :integer
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class FriendCircle < ActiveRecord::Base
  belongs_to :owner, class_name: "User"

  has_many(
    :memberships,
    class_name: "FriendCircleMembership"
  )

  has_many :members, through: :memberships
  has_many :post_shares
  has_many :posts, through: :post_shares
end
