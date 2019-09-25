# frozen_string_literal: true

require "rubygems/test_case"
require "open3"

class TestBuildCommands < Minitest::Test

  def test_rake_package_builds_ok
    skip unless File.exist?(File.expand_path("../../../Rakefile", __FILE__))

    output, status = Open3.capture2e("rake package")

    assert_equal true, status.success?, <<~MSG.chomp
      Expected `rake package` to work, but got errors:

      ```
      #{output}
      ```

      If you have added or removed files, make sure you run `rake update_manifest` to update the `Manifest.txt` accordingly
    MSG

    FileUtils.rm_f "pkg"
  end

  def test_ruby_setup_rb_builds_ok
    output, status = Open3.capture2e("ruby setup.rb")

    assert_equal true, status.success?, <<~MSG.chomp
      Expected `ruby setup.rb` to work, but got errors:

      ```
      #{output}
      ```
    MSG
  end

end
