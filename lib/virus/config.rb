module Virus
  require 'singleton'

  class Config
    include Singleton

    CONFIG_FILE_NAME = 'virus_config.json'.freeze
    DEV_PODS_FILE_NAME = 'virus_dev_pods.json'.freeze

    # virus_config.json 文件的路径
    attr_accessor :config_file_path
    attr_accessor :config_file_hash

    # 本地调试 pod 组建的 配置文件路径
    attr_accessor :virus_dev_pods_file_path

    # 每一个 pod 组件, 对应的 AFNetworking.rb (VirusFile) 路径
    attr_accessor :virus_files

    # 记录 每一个组件 预编译的 二进制 对应的 xcode 版本, 因为不同 xcode 版本编译得到的二进制 不一定能兼容
    attr_accessor :binary_xcode_version

    # 忽略 处理的 pod 组件 数组
    attr_accessor :ignore_pods

    def setup(config_file_path)
      config_file_path ||= File.expand_path(CONFIG_FILE_NAME, Dir.pwd.chomp)
      puts "[Virus] config json filepath: #{config_file_path}".green
      @config_file_path = Pathname.new(config_file_path)
      raise "[Virus] can not find #{CONFIG_FILE_NAME} at path #{config_file_path}" unless @config_file_path.exist?

      @config_file_hash = JSON.parse(File.read(@config_file_path))
      valid_config_file

      setup_virus_files
      setup_virus_dev_pods
      setup_binary_xcode_version
      setup_ignore_pods
    end

    private

    def valid_config_file
      {
        'virus_files' => Array,
        'ignore_pods' => Array
      }.each do |k, v|
        raise "[Virus] #{k} key can not be found in virus_config.json" unless @config_file_hash[k]
        raise "[Virus] #{k} not matched type #{v}" if @config_file_hash[k].class != v
      end
    end

    def setup_virus_files
      files = []
      @config_file_hash['virus_files'].map { |expr|
        Dir.glob(expr)
      }.each do |arr|
        files = files.concat(arr)
      end
      raise '[Virus] not exist Virusfile' if files.empty?

      @virus_files = files
    end

    def setup_virus_dev_pods
      path = @config_file_hash['virus_dev_pods']
      @virus_dev_pods_file_path = File.expand_path(path, Dir.pwd)
    end

    def setup_binary_xcode_version
      @binary_xcode_version = @config_file_hash['binary_xcode_version']
    end

    def setup_ignore_pods
      @ignore_pods = @config_file_hash['ignore_pods']
    end
  end
end