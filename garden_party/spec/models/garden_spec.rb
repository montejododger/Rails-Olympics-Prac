# == Schema Information
#
# Table name: gardens
#
#  id              :bigint           not null, primary key
#  name            :string           not null
#  size            :integer          not null
#  garden_owner_id :bigint           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'rails_helper'

RSpec.describe Garden, type: :model do
  let (:user) { User.create(username: "AppleSauce") }
  subject { Garden.create(name: "The Oasis", size: 1000, garden_owner_id: user.id) }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name).scoped_to(:garden_owner_id) }
  it { should validate_presence_of(:size) }
  it { should belong_to(:garden_owner).class_name(:User) }
  it { should have_many(:flowers).class_name(:Flower) }

  it "has a foreign key constraint and (exactly one) index for `garden_owner_id`" do
    schema = File.read('db/schema.rb')

    expect(/add_foreign_key \"gardens\", \"users\", column: \"garden_owner_id\"/ =~ schema).not_to be(nil)
    expect(ActiveRecord::Base.connection.index_exists?(:gardens, [:garden_owner_id, :name])).to be(true)
    expect(ActiveRecord::Base.connection.index_exists?(:gardens, :garden_owner_id)).to be(false)
  end

  it "can be successfully destroyed" do
    user = User.create!(username: "Bill")
    Flower.create!(flower_type: "Rose", gardener_id: user.id, garden_id: subject.id)
    expect { subject.destroy }.not_to raise_error
  end
end