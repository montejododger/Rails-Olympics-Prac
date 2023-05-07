# == Schema Information
#
# Table name: flowers
#
#  id          :bigint           not null, primary key
#  flower_type :string           not null
#  gardener_id :bigint           not null
#  garden_id   :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Flower < ApplicationRecord
  validates :flower_type, presence: true

  belongs_to :gardener,
      foreign_key: :gardener_id,
      class_name: :User,
      inverse_of: :flowers


  belongs_to :garden,
      foreign_key: :garden_id,
      class_name: :Garden
end
