class CreateLabelings < ActiveRecord::Migration
  def change
    create_table :labelings do |t|
      t.references :label, index: true, foreign_key: true
      t.references :post, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
