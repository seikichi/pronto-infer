# frozen_string_literal: true

require 'test_helper'

require 'pathname'
require 'tmpdir'

class InferTest < Test::Unit::TestCase
  DummyRepository = Struct.new('DummyRepository', :path) do
    def blame(_path, _lineno)
      nil
    end
  end

  test '#run returns empty array when patches are nil' do
    infer = Pronto::Infer.new(nil)

    assert_equal([], infer.run)
  end

  test '#run returns messages when violations are found' do
    json = <<-REPORT_JSON
    [
      {
        "qualifier": "FOO",
        "file": "src/main/java/foo/bar/App.java",
        "line": 1
      }
    ]
    REPORT_JSON

    Dir.mktmpdir do |dir|
      File.write(File.join(dir, 'report.json'), json)
      ENV.store('PRONTO_INFER_OUT_DIR', dir)

      infer = Pronto::Infer.new(create_new_file_patches(Dir.pwd, 'src/main/java/foo/bar/App.java'))
      messages = infer.run

      assert_equal(1, messages.size)
      assert_equal('src/main/java/foo/bar/App.java', messages[0].path)
      assert_equal('FOO', messages[0].msg)
    end
  end

  private

  def create_new_file_patches(repo_path, new_file_path)
    repo = DummyRepository.new(Pathname.new(repo_path))
    patch = Rugged::Patch.from_strings(nil, "added\n", new_path: new_file_path)
    [Pronto::Git::Patch.new(patch, repo)]
  end
end
