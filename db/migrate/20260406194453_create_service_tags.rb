class CreateServiceTags < ActiveRecord::Migration[8.1]
  def change
    create_table :service_tags do |t|
      t.references :service, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
