class ReportsController 
  
  def getAll(req)
    reports = Report.all
    [200, "application/json", [reports.to_json]]
  end

  def create(req)
    report_params = parse_body(req)

    begin
      # Validar que los parámetros requeridos estén presentes
      raise ArgumentError, "Faltan parámetros obligatorios" if report_params["date"].nil? || report_params["tipo_de_reporte"].nil? || report_params["estado"].nil?
      # Intentar crear un nuevo reporte
      report = Report.new(report_params)
      report.save
    rescue ArgumentError => e
      res = [400, "application/json",  error: e.message]
    rescue ActiveModel::UnknownAttributeError => e
      res = [400, "application/json",  error: e.message]
    else
      res = [201, "application/json", report.to_json]
    ensure
      
    end
    return res
  end

  private

  # Método para parsear el cuerpo de la solicitud en JSON
  def parse_body(req)
    body = req.body.read
    if body.empty?
      {}  # Si el cuerpo de la solicitud está vacío, devolvemos un hash vacío
    else
      JSON.parse(body).transform_keys(&:underscore)
    end
  rescue JSON::ParserError
    {}  # En caso de error al parsear, devolvemos un hash vacío
  end
end
