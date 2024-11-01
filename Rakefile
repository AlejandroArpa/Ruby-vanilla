require "active_record"
require "yaml"

# Cargar la configuración de la base de datos desde un archivo
db_config = YAML.load_file('app/config/database.yml')

namespace :db do
  desc "Crear la base de datos para el entorno actual"
  task :create do
    # Seleccionar la configuración del entorno actual
    env = ENV['RACK_ENV'] || 'development'
    config = db_config[env]

    # Verificar si la configuración es válida
    if config.nil? || config['database'].nil? || config['database'].empty?
      abort("Error: La configuración de base de datos para el entorno '#{env}' está incompleta o el nombre de la base de datos está vacío.")
    end

    ActiveRecord::Base.establish_connection(config)

    begin
      ActiveRecord::Base.connection
      puts "La base de datos '#{config['database']}' ya existe."
    rescue ActiveRecord::NoDatabaseError
      ActiveRecord::Base.establish_connection(config.merge('database' => nil))
      ActiveRecord::Base.connection.create_database(config['database'])
      puts "Base de datos '#{config['database']}' creada."
    end
  end

  desc "Ejecutar migraciones en la base de datos"
  task :migrate do
    env = ENV['RACK_ENV'] || 'development'
    config = db_config[env]
    ActiveRecord::Base.establish_connection(config)
    Dir.glob("db/migrate/*.rb").each { |file| require_relative file }
    ActiveRecord::Migrator.migrate("db/migrate")
    puts "Migraciones ejecutadas."
  end

  desc "Eliminar la base de datos para el entorno actual"
  task :drop do
    env = ENV['RACK_ENV'] || 'development'
    config = db_config[env]
    ActiveRecord::Base.establish_connection(config)

    ActiveRecord::Base.connection.drop_database(config['database'])
    puts "Base de datos '#{config['database']}' eliminada."
  end
end
