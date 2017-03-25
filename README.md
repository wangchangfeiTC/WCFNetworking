# WCFNetworking
基于AFNetworking的网络请求封装
WCFNetworking，是一套基于AFNetworking 3.0.0封装的网络库，提供了更高层次的抽象和更方便的调用方式,请求回调的数据可以进行缓存处理,下次进来可以加载缓存数据. 另外提供了上传图片的方法.


特性
支持全局配置请求的公共信息
提供大多数网络访问方式和相应的序列化类型
提供api请求结果映射接口，可以自行转换为相应的数据格式
api请求代理回调方式(delegate）
api配置简单
支持批量请求、链式请求等特殊需求
可随时取消未完成的网络请求
提供请求前网络状态检测

##使用方法

1. 建立数据请求模型modle,继承自BaseModel
2. 控制器ViewController继承协议BaseModelProtocol
3. 控制器ViewController实例化model
4. 拿着model读缓存数据,或者去请求数据
5.获取请求数据,进行处理


##举例说明
##HomeViewController里请求数据,对数据处理
--------------------------------------- Usage -----------------------------------
#import "HomeViewController.h"
#import "HomeDataModel.h"

@interface HomeViewController ()<BaseModelProtocol>
@property (nonatomic,strong)HomeDataModel *dataModel;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"首页";
    
    //如果之前保存了缓存数据,可以加载缓存数据
    [self.dataModel readCacheDataWithCallback:^(BaseResponse *response, NSError *error) {
        if (nil == error) {
            //返回的数据
            HomeDataResponse *resp = (HomeDataResponse *)response;
            //这里处理数据

        }
    }];
    
    
    //请求数据
    [self.dataModel getHomeData];
    NSLog(@"开始请求数据...");
}

- (void)getDataFinish:(BaseModel *)baseModel netError:(NSError *)error{

    NSLog(@"请求错误 %@",error);
}

- (void)getDataFinish:(BaseModel *)baseModel netResponse:(BaseResponse *)response{

    if ([baseModel isKindOfClass:[HomeDataModel class]]) {
        
        //返回的数据
        HomeDataResponse *resp = (HomeDataResponse *)response;
        //这里处理数据
    }
}

- (HomeDataModel *)dataModel{

    if (nil == _dataModel) {
        //cache 缓存,下次进来可以直接读缓存数据
        _dataModel = [[HomeDataModel alloc]initWithDelegate:self cache:NO];
    }
    return _dataModel;
}

@end

--------------------------------------------- end ----------------------------------------------

环境要求
该库需运行在 iOS 8.0 和 Xcode 7.0以上环境.
