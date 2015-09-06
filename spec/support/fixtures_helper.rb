module FixturesHelper
  def fixture(name)
    File.open(File.expand_path("../../fixtures/#{name}", __FILE__), 'r')
  end
end
