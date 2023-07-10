require 'minitest/autorun'

def macos?
  ENV['RUNNER_OS'] && ENV['RUNNER_OS'] == 'macOS'
end

class WithDockerTest < Minitest::Test
  SETUP = begin
    `docker-compose build --no-cache` unless macos?
  end

  def test_debian_10
   test with: 'debian_12'
  end

  private

  def test(with:)
    assert_equal(`docker-compose run --rm #{with}`.strip, 'wkhtmltopdf 0.12.6 (with patched qt)') unless macos?
  end
end
