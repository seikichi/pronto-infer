# frozen_string_literal: true

require 'pronto'
require 'json'

module Pronto
  class Infer < Runner
    def run
      return [] unless @patches

      @patches
        .select(&method(:valid_patch?))
        .flat_map(&method(:inspect))
        .compact
    end

    private

    Offence = Struct.new(:path, :line, :message)

    def infer_out_dir
      ENV['PRONTO_INFER_OUT_DIR'] || (raise 'Please set `PRONTO_INFER_OUT_DIR` to use pronto-infer')
    end

    def infer_project_root_dir
      File.expand_path(ENV['PRONTO_INFER_PROJECT_ROOT_DIR'] || '.')
    end

    def valid_patch?(patch)
      patch.additions.positive?
    end

    def inspect(patch)
      offences = infer_offences.select { |offence| offence.path == patch.new_file_full_path.to_s }

      offences.flat_map do |offence|
        patch.added_lines
             .select { |line| line.new_lineno == offence.line }
             .map { |line| new_message(offence, line) }
      end
    end

    def infer_offences
      @infer_offences ||=
        begin
          path = File.join(infer_out_dir, 'report.json')
          read_infer_report(path)
        end
    end

    def read_infer_report(path)
      report = JSON.parse(File.read(path))
      report.map do |r|
        Offence.new(File.join(infer_project_root_dir, r['file']), r['line'], r['qualifier'])
      end
    end

    def new_message(offence, line)
      path = line.patch.delta.new_file[:path]
      Message.new(path, line, :warning, offence.message, nil, self.class)
    end
  end
end
