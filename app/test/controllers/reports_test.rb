require 'minitest/autorun'
require 'rack/test'
require_relative '../../app/controllers/reports_controller'
require_relative '../../app/models/report'


class ReportTest < Minitest::Test

  def report
    ReportsController.new
  end

  def test_get_all
    # Crear datos falsos que simulen el resultado de Report.all
    mock_reports = [{ id: 1, name: "Report 1" }, { id: 2, name: "Report 2" }]
    
    # Stub para reemplazar temporalmente Report.all con mock_reports
    Report.stub :all, mock_reports do

      response = report.getAll(nil)
      # Verificar la respuesta
      assert_equal 200, response[0]
      assert_equal "application/json", response[1]["Content-Type"]
      assert_equal mock_reports.to_json, response[2].first
    end
  end
end
