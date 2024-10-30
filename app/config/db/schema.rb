ActiveRecord::Schema.define do
  create_table :reports, force: true do |t|
    t.integer :tipo_de_reporte, null: false, default: 0  # Enum para tipo de reporte
    t.integer :estado, null: false, default: 0           # Enum para estado
    t.timestamps
  end
end
