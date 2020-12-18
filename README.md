# swiftnetworkrequest
Ios swift 网络请求
ios 网络请求框架的使用，，及demo实现
HandyJSON，Moya rxswift 使用例子

//项目中依赖三方的方法---简单方式
cocoapods安装及依赖集成步骤：
 1，sudo gem install cocoapods       //安装cocoapods
 2， pod setup --verbose         //查看安装状态
 3，cd /Users/elliott/ITestProgram/NetworkTe              //进入项目根目录
 4， pod init          //初始化生成Podfile文件
 5，open -a Xcode Podfile                 //Xcode打开此文件
 6，pod 'Alamofire', '~> 5.4.0'    //有具体版本的
 6，pod 'Alamofire'     //无版本会根据iOS版本添加最新的合适iOS的版本
 7，pod install        //安装Podfile文件里配置的依赖，对于安装过的则不会重复安装，
 8，安装完成后 Please close any current Xcode sessions and use `NetworkTe.xcworkspace` for this project from now on. 重新打开   .xc   的项目，开发。

