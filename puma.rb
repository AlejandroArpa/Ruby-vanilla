

# Número de procesos trabajadores (mejora el rendimiento al manejar solicitudes simultáneas)
workers ENV.fetch("WEB_CONCURRENCY") { 2 }

# Número de hilos por trabajador
threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
threads threads_count, threads_count

# Puerto y entorno

port        ENV.fetch("PORT") { 3000 }
environment ENV.fetch("RACK_ENV") { "production" }

# Preload de la aplicación para mayor rendimiento
preload_app!

# Configuración para conexión a base de datos al arrancar cada trabajador
on_worker_boot do
  puts "Estableciendo conexión a la base de datos en #{ENV['RACK_ENV']}..."

  # Cargar el archivo database.yml manualmente
  db_config = YAML.load_file('app/config/database.yml')
  environment = ENV['RACK_ENV'] || 'development'
  ActiveRecord::Base.configurations = db_config

  # Establecer la conexión para el entorno actual
  ActiveRecord::Base.establish_connection(db_config[environment])
end



