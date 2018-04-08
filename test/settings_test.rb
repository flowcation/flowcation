require "test_helper"

class SettingsTest < Minitest::Test
  def setup
    @config = {
      'comment' => '<%#= ::comment:: %>',
      'generated-line' => "Nicht ändern! Generierter Code - wird überschrieben."
    }
  end
  
  def test_from_config
    Flowcation::Settings.from_config(@config)
    assert_equal Flowcation::Settings.get('comment'), '<%#= ::comment:: %>'
    assert_equal Flowcation::Settings.get('generated-line'), "Nicht ändern! Generierter Code - wird überschrieben."
  end
end
