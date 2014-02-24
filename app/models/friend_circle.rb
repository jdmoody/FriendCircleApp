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
end
