module Virus
  require 'singleton'
  # require 'cocoapods-core/specification'

  # https://guides.cocoapods.org/syntax/podfile.html
  class DevPods
    include Singleton

    attr_accessor :virus_dev_pods_hash

    def initialize
      @virus_dev_pods_hash = {}
    end

    def setup(virus_dev_pods_file_path)
      return if virus_dev_pods_file_path.nil? || virus_dev_pods_file_path.empty?

      @virus_dev_pods_hash = JSON.parse(File.read(virus_dev_pods_file_path))
    end

    private

  end
end