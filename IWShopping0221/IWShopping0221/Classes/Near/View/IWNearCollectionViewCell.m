

#import "IWNearCollectionViewCell.h"

@interface IWNearCollectionViewCell ()
@property(nonatomic ,strong)UIImageView *bgView;
@property(nonatomic ,strong)UILabel *nameLabel;
@property(nonatomic ,strong)UIImageView *topImageView;
@end

// 随机色
#define kArc4randomColor kColorRGB(arc4random_uniform(254), arc4random_uniform(254), arc4random_uniform(254))
//#define kArc4randomColor [UIColor clearColor]

@implementation IWNearCollectionViewCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        //底部图片
        self.bgView = [[UIImageView alloc]initWithFrame:frame];
        self.bgView.contentMode = UIViewContentModeScaleAspectFill;
        self.bgView.clipsToBounds = YES;
        self.bgView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.bgView];
        
        //上面图片
        self.topImageView = [[UIImageView alloc] init];
        self.topImageView.image = [UIImage imageNamed:@"APMHomeGlass"];
        self.topImageView.backgroundColor = [UIColor clearColor];
        [self.bgView addSubview:self.topImageView];
        
        //名字
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.backgroundColor = [UIColor clearColor];
        self.nameLabel.numberOfLines = 1;
        self.nameLabel.textColor = IWColor(95, 110, 100);
        self.nameLabel.font = kFont24px;
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.nameLabel];
        
    }
    return self;
}


-(void)setModel:(IWNearTopModel *)model{
    _model = model;
    self.bgView.frame = CGRectMake(0,0,kNearTopItemW,kNearTopItemH);
    
    [self.topImageView sd_setImageWithURL:[NSURL URLWithString:kImageTotalUrl(model.imageName)] placeholderImage:[UIImage imageNamed:@"IWHomeSign"]];
    
    self.topImageView.frame = CGRectMake(0, 0, kNearTopItemW, kNearTopItemW);
    
    self.nameLabel.text = model.nameTitle;
    
    if (model.nameTitle.length > 3) {
        self.nameLabel.font = kFont20px;
    }else{
        self.nameLabel.font = kFont24px;
    }
    
    self.nameLabel.frame = CGRectMake(0, CGRectGetMaxY(self.topImageView.frame) + 5, self.bgView.frame.size.width, kNearTopItemH - CGRectGetMaxY(self.topImageView.frame) - 5);
}

@end
