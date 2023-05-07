# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  username   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.create(username: "AppleSauce") }
  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }
  it { should have_many(:gardens).class_name(:Garden) }
  it { should have_many(:flowers).class_name(:Flower) }
  it { should have_many(:flowers_in_all_gardens).through(:gardens).source(:flowers) }
  it { should have_many(:gardens_with_my_flowers).through(:flowers).source(:garden) }

  it "has an index on `username`" do
    expect(ActiveRecord::Base.connection.index_exists?(:users, :username)).to be(true)
  end

  it "makes sure associations are bi-directional" do
    Garden.create!(name: "Garden", size: 100, garden_owner_id: subject.id)
    Flower.create!(flower_type: "Rose", gardener_id: subject.id, garden_id: Garden.first.id)
    flower = subject.flowers.first
    garden = subject.gardens.first
    expect(subject.object_id == flower.gardener.object_id).to be(true)
    expect(subject.object_id == garden.garden_owner.object_id).to be(true)
  end

  it "can be successfully destroyed" do
    Garden.create!(name: "Garden", size: 100, garden_owner_id: subject.id)
    Flower.create!(flower_type: "Rose", gardener_id: subject.id, garden_id: Garden.first.id)
    expect { subject.destroy }.not_to raise_error
  end
end
