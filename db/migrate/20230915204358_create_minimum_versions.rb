class CreateMinimumVersions < ActiveRecord::Migration[7.0]
  def change
    create_table :minimum_versions do |t|
      t.integer :platform
      t.string :version_number
      t.string :build_number
      t.boolean :required
      t.text :description

      t.timestamps
    end
  end
end
