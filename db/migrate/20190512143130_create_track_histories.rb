# frozen_string_literal: true

class CreateTrackHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :track_histories do |t|
      t.string :noresi
      t.string :expedition_type
      t.string :status
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
