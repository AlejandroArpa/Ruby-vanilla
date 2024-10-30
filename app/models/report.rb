class Report < ActiveRecord::Base
  enum :tipo_de_reporte, { cafe: 0, baño: 1 }
  enum :estado, { nuevo: 0, en_progreso: 1, resuelto: 2 }
  validates :tipo_de_reporte, presence: true
  validates :estado, presence: true
end