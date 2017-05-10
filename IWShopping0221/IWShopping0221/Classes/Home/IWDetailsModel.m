//
//  IWDetailsModel.m
//  IWShopping0221
//
//  Created by MacBook on 2017/2/25.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWDetailsModel.h"

@interface IWDetailsModel ()
@property (nonatomic,readonly,assign) CGRect btnF;
@end

@implementation IWDetailsModel
- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.standardArr = @[@"80g/包",@"60g/包",@"90g/包",@"100g/包"];
        self.knowStr = @"运费：新用户注册包邮，没介绍个朋友再送一次，机会可以累加。";
        self.taxRate = @"税率：本商品税率11.9%";
        self.imgUrl = @"https://img30.360buyimg.com/popWaterMark/jfs/t3940/267/1460377047/348820/7662895a/58772777Nae9a52f3.jpg";
        
        // Frame
        [self standardFrame];
    }
    return self;
}

// 规格相关Frame
- (void)standardFrame
{
    _btnFArr = [[NSMutableArray alloc] init];
    // 按钮:30 * 70 上:15 下:15
    // 规格背景宽度
    CGFloat viewW = kViewWidth - kFRate(26);
    // 规格Label宽/高
    UILabel *oneLabel = [[UILabel alloc] init];
    oneLabel.font = kFont28px;
    oneLabel.text = @"规格";
    [oneLabel sizeToFit];
    CGFloat standLabelW = oneLabel.frame.size.width;
    CGFloat standLabelH = oneLabel.frame.size.height;
    // 按钮宽度/高
    CGFloat btnW = ((viewW - standLabelW - kFRate(13)) - kFRate(13) * 2) / 3;
    CGFloat btnH = kFRate(30);
    // 行数
    NSInteger linNum;
    if (self.standardArr.count % 3 > 0) {
        linNum = self.standardArr.count / 3 + 1;
    }else{
        linNum = self.standardArr.count / 3;
    }
    for (NSInteger i = 0; i < linNum; i ++) {
        for (NSInteger j = 0; j < 3; j ++) {
            CGRect btnF = CGRectMake(kFRate(13) + (btnW + kFRate(13)) * j + standLabelW, kFRate(15) + (btnH + kFRate(5) )* i, btnW, btnH);
            [_btnFArr addObject:[NSValue valueWithCGRect:btnF]];
            _btnF = btnF;
        }
    }
    if (linNum == 0) {
        _standardViewF = CGRectMake(kFRate(13), kFRate(40), kViewWidth - kFRate(26), kFRate(40));
    }else{
        _standardViewF = CGRectMake(kFRate(13), kFRate(40), kViewWidth - kFRate(26), linNum * kFRate(30) + kFRate(30) + (linNum - 1) + kFRate(5));
    }
    
    _standardLabelF = CGRectMake(0, (_standardViewF.size.height - standLabelH) / 2, standLabelW, standLabelH);
    
    // 购买数量
    UILabel *shoopLabel = [[UILabel alloc] init];
    shoopLabel.text = @"购买数量";
    shoopLabel.font = kFont28px;
    [shoopLabel sizeToFit];
    _shoopNumW = shoopLabel.frame.size.width;
    
    _cellOneH = CGRectGetMaxY(_standardViewF) + kFRate(60);
    
    
    
    // cell2
    CGSize maximumLabelSize = CGSizeMake(kViewWidth - kFRate(26), MAXFLOAT);//labelsize的最大值
    NSDictionary *attribute = @{NSFontAttributeName: kFont22px};
    CGSize expectSize = [self.knowStr boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    CGFloat detailLabelH = expectSize.height;
    _freightF = CGRectMake(kFRate(13), kFRate(35), kViewWidth - kFRate(26), detailLabelH);
    
    CGSize maximumLabelSize1 = CGSizeMake(kViewWidth - kFRate(26), MAXFLOAT);//labelsize的最大值
    NSDictionary *attribute1 = @{NSFontAttributeName: kFont22px};
    CGSize expectSize1 = [self.taxRate boundingRectWithSize:maximumLabelSize1 options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute1 context:nil].size;
    CGFloat detailLabelH1 = expectSize1.height;
    _taxRateF = CGRectMake(kFRate(13), CGRectGetMaxY(_freightF) + kFRate(5), kViewWidth - kFRate(26), detailLabelH1);
    _cellTwoH = CGRectGetMaxY(_taxRateF) + kFRate(15);
    
    // 详情图片
    NSData *data = [NSData dataWithContentsOfURL:[NSURL  URLWithString:self.imgUrl]];
    UIImage *image = [UIImage imageWithData:data]; // 取得图片
    // 本地沙盒目录
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 得到本地沙盒中名为"MyImage"的路径，"MyImage"是保存的图片名
    NSString *imageFilePath = [path stringByAppendingPathComponent:@"MyImage"];
    // 将取得的图片写入本地的沙盒中，其中0.5表示压缩比例，1表示不压缩，数值越小压缩比例越大
    BOOL success = [UIImageJPEGRepresentation(image,1) writeToFile:imageFilePath  atomically:YES];
    if (success){
        //读取图片
        self.imgSize = [UIImage imageWithContentsOfFile:imageFilePath].size;
    }
    CGFloat ZZZZ = kViewWidth / self.imgSize.width;
    _cellThreeH = self.imgSize.height * ZZZZ;
    
}

@end
