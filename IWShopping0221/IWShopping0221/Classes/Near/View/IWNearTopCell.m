//
//  APMHomeFirstCell.m

//
//  Created by xiaohai on 16/11/8.
//  Copyright © 2016年  All rights reserved.
//

#import "IWNearTopCell.h"
#import "IWNearCollectionViewCell.h"

NSString *const IWNearCollectionViewCellIdentifier = @"IWNearCollectionViewCellIdentifier";
#define kNearTopFirstX 33
#define kNearTopFirstY 15
@interface IWNearTopCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak)UICollectionView *collectionView;
@property (nonatomic, weak)UIImageView *backgroundImageView;
@end
@implementation IWNearTopCell

// 随机色
//#define kArc4randomColor kColorRGB(arc4random_uniform(254), arc4random_uniform(254), arc4random_uniform(254))
#define kArc4randomColor [UIColor clearColor]

#pragma mark - 初始化
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifierIWNearTopCell = @"IWNearTopCell";
    IWNearTopCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierIWNearTopCell];
    if (cell == nil) {
        cell = [[IWNearTopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierIWNearTopCell];
        cell.backgroundColor = [UIColor clearColor];
        // 去掉选中效果
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
#pragma mark - 初始化
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addCollectionView];
    }
    return self;
}
#pragma mark - 重置cell宽度
- (void)setFrame:(CGRect)frame
{
    frame.size.width = kViewWidth;
    [super setFrame:frame];
}
-(void)setModelArray:(NSArray *)modelArray{
    _modelArray = modelArray;
    //重新设置frame
    self.backgroundImageView.frame = CGRectMake(0,0,kViewWidth, kFRate(kNearTopFirstY) +  (modelArray.count + 3) / 4 * kRate( kNearTopItemH));
    self.collectionView.frame = CGRectMake(kFRate(kNearTopFirstX),kFRate(kNearTopFirstY),kViewWidth - 2 * kFRate(kNearTopFirstX), (modelArray.count + 3) / 4 * kFRate(kNearTopItemH + kNearTopFirstY) - kFRate(kNearTopFirstY));
    
    [self.collectionView reloadData];
}

#pragma mark - 生成UICollectionView
- (void)addCollectionView
{
    //    底部背景
    UIImageView *backgroundImageView = [[UIImageView alloc]init];
//    backgroundImageView.image = [UIImage getSanJiaoImage:_IMG(@"CTDAvenueAIXLNewbolilast")];
    backgroundImageView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backgroundImageView];
    self.backgroundImageView = backgroundImageView;
    backgroundImageView.userInteractionEnabled = YES;
    
    //collectionView创建
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(kFRate(kNearTopItemW),kFRate(kNearTopItemH));
    //横行和纵向间距
    layout.minimumLineSpacing = kFRate(15);
    layout.minimumInteritemSpacing = kFRate(30);
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //这里的尺寸没有用   setmodel方法里面重新赋值了
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(kFRate(kNearTopFirstX),kFRate(kNearTopFirstY),kViewWidth - 2 * kFRate(kNearTopFirstX), (_modelArray.count + 3) / 4 * kFRate(kNearTopFirstY + kNearTopItemH) ) collectionViewLayout:layout];
    
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    //不滑动
    collectionView.scrollEnabled = NO;
    collectionView.pagingEnabled = YES;
    [backgroundImageView addSubview:collectionView];
    

    //注册cell和ReusableView（相当于头部）
    [collectionView registerClass:[IWNearCollectionViewCell class] forCellWithReuseIdentifier:IWNearCollectionViewCellIdentifier];
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
    self.collectionView = collectionView;
}
#pragma mark - 组数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
#pragma mark - 个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return  self.modelArray.count;
}
#pragma mark - 生成cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    IWNearCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:IWNearCollectionViewCellIdentifier forIndexPath:indexPath];
    IWNearTopModel *model = self.modelArray[indexPath.row];
    cell.model = model;
//    cell.backgroundColor = [UIColor blueColor];
    return cell;
}
#pragma mark UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.cellClick) {
        IWNearTopModel *model = self.modelArray[indexPath.row];
        self.cellClick(model,indexPath.row);
    }
}
@end
