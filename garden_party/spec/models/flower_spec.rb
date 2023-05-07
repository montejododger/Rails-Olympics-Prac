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
require 'rails_helper'

RSpec.describe Flower, type: :model do
  it { should validate_presence_of(:flower_type) }
  it { should belong_to(:gardener).class_name(:User) }
  it { should belong_to(:garden).class_name(:Garden) }

  describe "Foreign key constraints and indexes" do
    it "has a foreign key constraint and index on `gardener_id`" do
      schema = File.read('db/schema.rb')

      expect(/add_foreign_key \"flowers\", \"users\", column: \"gardener_id\"/ =~ schema).not_to be(nil)
      expect(ActiveRecord::Base.connection.index_exists?(:flowers, :gardener_id)).to be(true)
    end

    it "has a foreign key constraint and index on `garden_id`" do
      schema = File.read('db/schema.rb')

      expect(/add_foreign_key \"flowers\", \"gardens\"/ =~ schema).not_to be(nil)
      expect(ActiveRecord::Base.connection.index_exists?(:flowers, :garden_id)).to be(true)
    end
  end
end