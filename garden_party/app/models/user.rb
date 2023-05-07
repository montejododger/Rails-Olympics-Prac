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
    validates :username, presence: true, uniqueness: true

    has_many :gardens,
        foreign_key: :garden_owner_id,
        class_name: :Garden,
        dependent: :destroy,
        inverse_of: :garden_owner


    has_many :flowers,
        foreign_key: :gardener_id,
        class_name: :Flower,
        dependent: :destroy,
        inverse_of: :gardener

    has_many :flowers_in_all_gardens,
        through: :gardens,
        source: :flowers

    has_many :gardens_with_my_flowers,
        through: :flowers,
        source: :garden



end
