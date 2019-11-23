# Virus

## 直接使用 CocoaPods 管理项目组件依赖存在的问题

- 控制 开发随意添加 各种 pod 组件, 到 App 项目中带来的问题 
- 组件之间的版本依赖关系、App依赖组件版本, 都难以控制
- 如果需要以 development pods 方式, 调试某个 pod 组件时, 还需要去 Podfile 修改 pod 引用方式
- 如果组件实现 源码 和 二进制 切换, 也存在很多的问题
  - 市面上很多切换的实现, 是基于2个仓库, 一个存源码, 一个存二进制
  - 通过环境变量或者什么的, 达到切换, 但是同样需要修改 Podfile 中的 pod 引用方式
  - 二进制失效的问题
- 我们项目中并没有过多使用 podspec repo 来作为组件发布的仓库, 因为这样流程太麻烦, 严重影响内部组件的开发效率
- 而解决这些问题的核心, 必须要接管 pod install 的调用, 继而可以做更多的扩展, 这个库的就是这个作用

## 安装

Add this line to your application's Gemfile:

```ruby
gem 'virus'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install virus

## 使用

### 参考 Example App 工程

[打开这个目录](Examples/App)

### 修改你的 App 项目中的 Podfile

```ruby
# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

# 1、导入依赖的 gem
require 'virus'

target 'App' do
  Virus::Installer.install(self) # 2、调用 Virus 接管 pod 'xxx' 即可
end
```

### [virus_config.json](Examples/App/virus_config.json) 主配置文件

在你的 App 项目/Podfile 同级根目录 添加 virus_config.json 配置文件

```json
{
	"virus_files": [
    "Virusfiles/**/*.rb"
  ],
  "virus_dev_pods": "Virusfiles/virus_dev_pods.json",
	"binary_xcode_version": {
		"xcode10.2": "v1.0",
		"xcode11.0": "v2.0",
		"default": "v2.0"
	},
	"ignore_pods": [
		"ZHMiddlewareModuleMap",
		"Nimble",
		"Quick",
		"RxAtomic",
		"RxTest",
		"RxBlocking",
		"Mockingjay",
		"URITemplate",
		"SwiftLint",
		"FirebaseAnalytics",
		"FirebaseCore",
		"FirebaseCoreDiagnostics",
		"FirebaseCoreDiagnosticsInterop",
		"FirebaseInstanceID",
		"GoogleAppMeasurement",
		"nanopb"
	]
}
```

- 配置 所有 组件对应的 rb 文件的搜索路径
- 配置 development pods 
- ~~binary 二进制的 xcode 版本信息~~
- 忽略接管的 pod

### [virus_config.json](/Users/xiongzenghui/Desktop/virus/Examples/App/Virusfiles/virus_dev_pods.json)  配置 development pods 

```json
{
	"AFNetworking": {
		"path": "/Users/xiongzenghui/Desktop/virus/Examples/App/AFNetworking-3.2.1"
	},
	"FMDB": {
		"git": "https://github.com/ccgus/fmdb.git",
		"tag": "v2.7"
	},
	"GBDeviceInfo": {
		"git": "https://github.com/lmirosevic/GBDeviceInfo.git",
		"commit": "770da18"
	}
}
```

### 每一个具体的 pod 引用

比如 AFNetworking 对应的 [AFNetworking.rb](Examples/App/Virusfiles/vendor/AFNetworking.rb) 文件: 

```ruby
VirusFile.new do |v|
  v.name = 'AFNetworking'
  v.version = '2.7.0'
end
```

- 每一个组件都必须添加这样对应的 rb 文件
- 这样才能严格控制 App 工程的 组件 **添加、删除、更新** 带来的不确定性
- 后续会考虑提供脚本自动生成这个问题件

### 二进制与源码 切换的配置

TODO

### 剩下的

pod install 就完事!

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).


