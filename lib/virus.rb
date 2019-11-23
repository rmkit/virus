require 'virus/version'

module Virus
  require 'json'

  require_relative 'virus/config'
  require_relative 'virus/dev_pods'

  class Error < StandardError; end
  class Installer
    #
    # @param pod_file => Pod::Podfile 对象
    #
    # @param options[:config] => virus_config.json 文件的路径
    # @param options[:binary_mode] => 1) debug 2) adhoc 3) release
    # @param options[:all_source] => true 或 false
    #
    def self.install(pod_file, options = {})
      Config.instance.setup(options[:config])
      DevPods.instance.setup(Config.instance.virus_dev_pods_file_path)
    end
  end
end

def virus_pre_install(&blk); end
def virus_post_install(&blk); end