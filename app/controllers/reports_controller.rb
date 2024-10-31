require_relative '../models/report'

class ReportsController 

  def getAll(env)
    reports = Report.all
    body = [200, "application/json", reports]
    response(body)
  end


  def create(env)
    report_params, _ = extract_env(env)
    begin
      raise ArgumentError, "Faltan parámetros obligatorios" if report_params["tipo_de_reporte"].nil? || report_params["estado"].nil?
      report = Report.new(report_params)
      report.save
    rescue ArgumentError => e
      body = [400, "application/json",  error: e.message]
    rescue ActiveModel::UnknownAttributeError => e
      body = [400, "application/json",  error: e.message]
    else
      body = [201, "application/json", report]
    ensure
    end
    response(body)
  end

  def getOne(env)
    _, param = extract_env(env)
    id = param.to_i
    report_exists = Report.exists?(id)
    if report_exists
      begin
        report = Report.find(id)
      rescue ArgumentError => e
        body = [400, "application/json",  error: e.message]
      else
        body = [200, "application/json", report]
      end
    else
      body = [404, "application/json",  error: "report not found"]
    end
    response(body)
  end

  def edit(env)
    report_params, param = extract_env(env)
    id = param.to_i
    report_exists = Report.exists?(id)
    if report_exists
      begin
        report = Report.find(id)
        report.update(report_params)
      rescue ArgumentError => e
        body = [400, "application/json",  error: e.message]
      else
        body = [200, "application/json", report]
      end
    else
      body = [404, "application/json",  error: "report not found"]
    end
    response(body)
  end

  def delete(env)
    _, param = extract_env(env)
    id = param.to_i
    report = Report.exists?(id)
    if(report)
      begin
        Report.find(id).destroy
      rescue 
        body = [400, "application/json",  error: "something happened"]
      end
      body = [200, "application/json",  data: "report deleted"]
    else
      body = [404, "application/json",  error: "report not found"]
    end
    response(body)
  end

  private

  def parse_body(req)
    body = req.body.read
    if body.empty?
      {}  
    else
      JSON.parse(body).transform_keys(&:underscore)
    end
  rescue JSON::ParserError
    {}  
  end

  private 

  def extract_env(env)
    req = Rack::Request.new(env)
    param = env['path_param']
    parse_body = parse_body(req)
    return [parse_body, param]
  end

  private 

  def response(body)
    res = Rack::Response.new
    res.status = body[0]
    res["Content-Type"] = body[1]
    data = body[2]
    res.write({ data: data }.to_json)
    res.finish
  end
end
