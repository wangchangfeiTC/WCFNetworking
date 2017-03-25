//
//  HomeScoreResponse.h
//  EFHealth
//
//  Created by nf on 16/3/29.
//  Copyright © 2016年 ef. All rights reserved.
//

#import "BaseResponse.h"
#import "HomeData.h"
@interface HomeDataResponse : BaseResponse
@property (nonatomic,strong)HomeData *data ;
@end
