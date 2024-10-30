guard :puma do
  watch(%r{^config/.+})
  watch(%r{^app/.+})
  watch(%r{^lib/.+})

  # Solo reinicia Puma si se modifica un archivo .rb
  watch(%r{^app/.+\.rb$})

  # Muestra una notificación cuando Puma se reinicia
  notification :off # Cambia a :on para habilitar notificaciones
end