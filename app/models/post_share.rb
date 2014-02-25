# == Schema Information
#
# Table name: post_shares
#
#  id               :integer          not null, primary key
#  post_id          :integer
#  friend_circle_id :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class PostShare < ActiveRecord::Base
  belongs_to :post
  belongs_to :friend_circle
end
