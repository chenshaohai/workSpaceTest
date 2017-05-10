
// 获得RGB颜色
#define kColorRGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// 获得RGB透明度颜色
#define kColorRGBA(r, g, b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/1.0]

#define kColorSting(sum) [UIColor HexColorToRedGreenBlue:sum]
//附近 顶部item 宽 高
#define  kNearTopItemW  40
#define  kNearTopItemH  55
// 1.判断是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

// 2.获得RGB颜色
#define IWColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

//红色的按钮
#define IWColorRed  IWColor(252, 56, 100)

// 3.自定义Log
#ifdef DEBUG
#define IWLog(...) NSLog(__VA_ARGS__)
#else
#define IWLog(...) NSLog(__VA_ARGS__)
#endif

// 4.是否为4inch
#define fourInch ([UIScreen mainScreen].bounds.size.height == 568)

// 5.微博cell上面的属性
/** 昵称的字体 */
#define IWStatusNameFont [UIFont systemFontOfSize:15]
/** 被转发微博作者昵称的字体 */
#define IWRetweetStatusNameFont IWStatusNameFont

/** 时间的字体 */
#define IWStatusTimeFont [UIFont systemFontOfSize:12]
/** 来源的字体 */
#define IWStatusSourceFont IWStatusTimeFont

/** 正文的字体 */
#define IWStatusContentFont [UIFont systemFontOfSize:13]
/** 被转发微博正文的字体 */
#define IWRetweetStatusContentFont IWStatusContentFont

/** 表格的边框宽度 */
#define IWStatusTableBorder 5

/** cell的边框宽度 */
#define IWStatusCellBorder 10

// 6.微博cell内部相册
#define IWPhotoW 70
#define IWPhotoH 70
#define IWPhotoMargin 10

// 7.常用的对象
#define IWNotificationCenter [NSNotificationCenter defaultCenter]

// 图片
#define _IMG(name) [UIImage imageNamed:(name)]

//宽 高
#define kViewWidth [UIScreen mainScreen].bounds.size.width
#define kViewHeight [UIScreen mainScreen].bounds.size.height

// 分割线颜色
#define kLineColor [UIColor HexColorToRedGreenBlue:@"d8d8dd"]

// 全局红色
#define kRedColor IWColor(252, 56, 100)

// 是否为6
#define kSix ([UIScreen mainScreen].bounds.size.height == 667 && [UIScreen mainScreen].bounds.size.width == 375)
// 是否为6+
#define kSixPlus ([UIScreen mainScreen].bounds.size.height == 736 && [UIScreen mainScreen].bounds.size.width == 414)
// 是否为6跟6+
#define kSixAndPlus ([UIScreen mainScreen].bounds.size.height == 736 || [UIScreen mainScreen].bounds.size.height == 667)
//iPhone 的比值
// ([UIScreen mainScreen].bounds.size.width > 375 ? ((sum)* 1.0 * kViewWidth / 375 ) : sum)
#define kRate(sum)  ((sum) * 1.0 / 320 * kViewWidth)
#define kFRate(sum) ([UIScreen mainScreen].bounds.size.width > 375 ? ((sum)* 1.0 * kViewWidth / 375 ) : sum)

/**
 *  字体大小
 */
#define kFont16px [UIFont systemFontOfSize:kFRate(9)]
#define kFont18px [UIFont systemFontOfSize:kFRate(9.5)]
#define kFont20px [UIFont systemFontOfSize:kFRate(10)]
#define kFont22px [UIFont systemFontOfSize:kFRate(11)]
#define kFont24px [UIFont systemFontOfSize:kFRate(12)]
#define kFont24pxBold [UIFont boldSystemFontOfSize:kFRate(12)]
#define kFont26px [UIFont systemFontOfSize:kFRate(13)]
#define kFont26pxBold [UIFont boldSystemFontOfSize:kFRate(13)]
#define kFont28px [UIFont systemFontOfSize:kFRate(14)]
#define kFont28pxBold [UIFont boldSystemFontOfSize:kFRate(14)]
#define kFont30px [UIFont systemFontOfSize:kFRate(15)]
#define kFont30pxBold [UIFont boldSystemFontOfSize:kFRate(15)]
#define kFont32px [UIFont systemFontOfSize:kFRate(16)]
#define kFont32pxBold [UIFont boldSystemFontOfSize:kFRate(16)]
#define kFont34px [UIFont systemFontOfSize:kFRate(17)]
#define kFont36px [UIFont systemFontOfSize:kFRate(18)]
#define kFont38px [UIFont systemFontOfSize:kFRate(19)]
#define kFont40px [UIFont systemFontOfSize:kFRate(20)]
#define kFont42px [UIFont systemFontOfSize:kFRate(21)]


#define kNetUrl @"http://api.rebate1688.com"
#define kImageUrl  @"http://weiyuntest-1253191691.image.myqcloud.com/"

#define kImageTotalUrl(imageName)  [NSString stringWithFormat:@"%@/%@",kImageUrl,imageName]

//支付宝 ID
#define kAliPayAppID  @"2017040506558991"
//支付宝 私钥
#define kRsa2PrivateKey  @"MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCLAmYQ9rYGhZ2SjMcp+0pCULvQgJz9lKX/tyOxnwJK3wbQUvk95i+ZDOxq2/GB6OnyKRBBDt/13ieMCfOBLlUch+osKXA/+p4/FlXcsRbiHoXK1/qkpI8ptBnNRK3PPabUKAdy/RC8zOltX0tGzOD1Ein0qRfTYTQR7JcsFaprBpNM3+Cg3uz6h0lIS005mZF/e0dBzAXxDb2bFrHt4PevH6iVkJF64n2Crz2umsaO1Riy97vopFHAFXSFrntxU6oPfopyz76Tiy+zJiW/HkAD0IfOVXh4htmetZdQe5Dw3+Ng2xO6YBvjUHVvq+X+QXV3YjMhFiw/1d0JFheB9rM7AgMBAAECggEAY4pPLhyMEbWCNRvLzjscXMpVAyPlxwu3ppos3BcB3D1CMtEHmxSGxvDjJk3i7WSsiXRwKDYPl48CAJxrmvhjh++ndwIhWB8NTB2hVEwXF8pFghAQce9IeNN3mm5wi7MZEFitpOCkKJ4PFPuk+sjg2XytQH4JCptTXvZs9et5wfK0KsRSURDDI1rt19yGpqjTupxSHtCSkIpPDK7dQJRu8LQJkSWktAJmTwceaat6NDSNCxc9GJVVbxi1mid1rpNFLaM7l3yZyqiaXrwq550VL+B2aykpZsF2Qhi+PSulwsVY0oxLSTnfgS9Ysz+S5bseDIlAhHzSP1iTiXBIpza20QKBgQD+KZ1bcGqYakad2JRiVAi/pk3/rJZdQbKNJJfkI6nVwkcOc4YYngX5zlExW5Rx9t7tBBVA2EbkESYwfQ200lEksEWrW7W9Xt/YynIBWfw/XojvVDO7Zs7sozV96lLBR3pAcOL8AzdWhfk8J/Vk5WqH6wF2bJbNja4QSfZynUeMgwKBgQCMA6q/2zEKixSzbd5jM43OcSd+R6bBosF33/2xsaiP3ZEOwWXqehjfc2EI/KqcJM0ogTrXMJSDcPFS7qPMgcbIudg6gep0/NyrWe/IwFz2Nz4JaNjW9DDm+pQXE1/MZxtO5cBMnwOsMdfMxT+a8P7s8HRem11BZsG5vbj+9t/w6QKBgQD5amsiRXJFud0sn1IWIDMpp5DZe0tfns4SVju8RQcwXuOOGe4ZEFH67+2biyxkngfr/drBdLw0qWOZp86giNfaMiVcYLY7bPQscZZpHx48LZAhlLbji6M6c3tV4nJte7BLtrv45UsT3ItV7jyRU9U0Jnmb9joS45tSHtL7bL6+8wKBgCV82dvSiTfkcx9zfEadSAuNGmDiOFDCDgDVlSxdf989GJiVyX7VQBGb59ArLlbuN4vvxdxV4n2q4MIuqOaZnKqjr7RCko7OIRsz0lKyxnEZ619DlkM/UFSXpMzk4BJvTM18EFezf508HyZxbY1Dl03DN7UY7ggTxizAEmcZnG35AoGAIURD9os/oeqW6kqh09z1Eoh/Io4vvDbotW3JA09Ozq3d4PMsdjSsYQwqXs1uod+L7r80aSUFz5LTF6o8Iu1XbhGZtnZwCTJZkMZkNDQnhsvO1bAf5uhuU7WBRvhu2R/5GG2zQ42UruUDTHlYoBf5Tt9eIkRzNj/BM+uToYgpkLE="

