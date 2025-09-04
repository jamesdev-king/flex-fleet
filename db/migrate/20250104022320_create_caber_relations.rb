# frozen_string_literal: true

class CreateCaberRelations < ActiveRecord::Migration[8.0]
  def change
    create_table :caber_relations do |t|
      t.references :subject, polymorphic: true, null: true, type: :string
      t.string :permission
      t.references :object, polymorphic: true, null: false, type: :string

      t.timestamps
      t.index %i[subject_id subject_type object_id object_type], unique: true
    end
  end
end
