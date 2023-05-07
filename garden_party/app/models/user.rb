# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  username   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
    validates :username, presence: true

    has_many :gardens,
    foreign_key: :garden_owner_id,
    class_name: :Garden,
    dependent: :destroy

    has_many :flowers,
    foreign_key: :gardener_id,
    class_name: :Flower,
    dependent: :destroy
end
