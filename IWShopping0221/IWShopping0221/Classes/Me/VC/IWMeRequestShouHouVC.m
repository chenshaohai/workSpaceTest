//
//  IWMeRequestShouHouVC.m
//  IWShopping0221
//
//  Created by s on 17/3/19.
//  Copyright © 2017年 sword. All rights reserved.
//   申请售后
#import "IWMeRequestShouHouVC.h"
#import "ATextView.h"
#import "IWMeTuiHuoCell.h"
#import "IWMeShouHouResultVC.h"


@interface IWMeRequestShouHouVC ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIGestureRecognizerDelegate>

// 表格，
@property (nonatomic,weak)UITableView *tableView;
//确认按钮
@property (nonatomic,weak)UIButton *SureButton;
// 选择
@property (nonatomic,weak)UIPickerView *pickerView;
//蒙版
@property (nonatomic,weak)UIView *mobanView;
@property (nonatomic,strong)NSArray *pickerList;
//类型选择
@property (nonatomic,weak)UILabel *selectLabel;
//输入框
@property (nonatomic,weak)ATextView *textView;


@end
@implementation IWMeRequestShouHouVC

- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"申请售后";
    self.view.userInteractionEnabled = YES;
    //    self.view.backgroundColor = kColorRGB(240, 240, 240);
    
    self.pickerList = @[@"只退款",@"只退货",@"退货并退款",@"只换货"];
    
    [self setupTableView];
}


-(void)setupTableView{
    //添加列表
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kViewWidth, kViewHeight - 64) style:UITableViewStylePlain];
    //去掉下划线
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    tableView.backgroundColor = kColorRGB(240, 240, 240);
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableHeaderView.frame = CGRectMake(0, 0, 0, 0.01);
    tableView.userInteractionEnabled = YES;
    self.tableView = tableView;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableView reloadData];
}
#pragma mark 提交
-(void)sure:(UIButton *)button{
    
    IWMeOrderFormModel *fatherModel =  self.model;
    
    IWMeOrderFormProductModel *model = [fatherModel.children firstObject];
    
    /*/*
     
     {
     addressId = 36;
     addressInfo = "";
     children =             (
     {
     attributeValue = "";
     count = 1;
     orderDetailId = 28;
     productId = 14;
     productName = "\U5e05\U6c14\U4f11\U95f2\U886c\U8863\U7537\U88c5";
     salePrice = 69;
     smarketPrice = 169;
     thumbImg = "/aigou/shop/20170312/53db2923-6413-474d-ac03-0d9f86a87add.jpg";
     }
     );
     createdTime = 1489514010000;
     expressNum = 755300189836;
     expressPrice = 0;
     orderId = 24;
     orderNum = 1489514010670;
     payPrice = 399;
     shopId = 14;
     shopName = "\U6fb3\U54c1\U835f";
     state = 1;
     updatedTime = 1489931125000;
     },
     */
    
    if ([self.selectLabel.text isEqual:@"请选择"]) {
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"请选择退货类型"];
        return;
    }
    
    
    NSString *refundString =   self.selectLabel.text;
    NSString *refundType = @"1";
    if ([refundString isEqual:@"只退款"]) {
        refundType =@"1";
    }else if ([refundString isEqual:@"只退货"]) {
        refundType =@"2";
    }else if ([refundString isEqual:@"退货并退款"]) {
        refundType =@"3";
    }else if ([refundString isEqual:@"只换货"]) {
        refundType =@"4";
    }
    
    IWLog(@"999%@999",self.textView.text);
    
    
    
    NSString *body = [NSString stringWithFormat:@"orderNum=%@&productId=%@&itemId=%@&productName=%@&thumbImg=%@&smarketPrice=%@&salePrice=%@&attributeValue=%@&refundType=%@&refundReason=%@&orderId=%@&orderDetailId=%@&userId=%@&userName=%@&shopId=%@",fatherModel.orderNum,model.productId,model.itemId,model.productName,model.thumbImg,model.smarketPrice,model.salePrice,model.attributeValue,refundType,self.textView.text,fatherModel.orderId,model.orderDetailId,[ASingleton shareInstance].loginModel.userId,[ASingleton shareInstance].loginModel.userName,fatherModel.shopId];
    
    //转码  必须要这一步，要不就挂了
    NSString *lastString = [body stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    [[ASingleton shareInstance]startLoadingInView:self.view];
    NSString *url = [NSString stringWithFormat:@"%@/order/serviceOrder?%@",kNetUrl,lastString];
    
    
    NSDictionary *lastDict = nil;
    
    __weak typeof(self) weakSelf = self;
    [IWHttpTool postWithURL:url  params:lastDict success:^(id json) {
        [[ASingleton shareInstance] stopLoadingView];
        
        if (!json || ![json isKindOfClass:[NSDictionary class]] || !json[@"code"]) {
            [[TKAlertCenter defaultCenter]postAlertWithMessage:@"订单创建失败"];
            return ;
        }
         NSDictionary *data = json[@"data"];
        
         if (!data || ![data isKindOfClass:[NSDictionary class]] || [data isEqual:@""] ){
            [[TKAlertCenter defaultCenter]postAlertWithMessage:@"订单创建失败"];
           return ;
         }
        
        /*{
         code = 0;
         data =     {
         attributeValue = "";
         createdTime = 1490758660000;
         itemId = 9120;
         orderDetailId = 573;
         orderId = 280;
         productId = 16;
         productName = "2017\U65b0\U6b3e\U76ae\U5939\U514b\U7537\U88c5\U6625\U5b63";
         refundCount = 1;
         refundId = 98;
         refundMoney = 159;
         refundNum = 1490163425712;
         refundReason = "";
         refundType = 2;
         salePrice = 159;
         shopId = 16;
         shopName = "\U6021\U666f\U9ea6\U5f53\U52b3\U5206\U5e97";
         smarketPrice = 499;
         state = 0;
         thumbImg = "/aigou/shop/20170312/e0bafff0-e8f3-4000-8290-05f91b29d503.jpg";
         updatedTime = 1490758660000;
         };
         message = success;
         }
*/
       
        
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"订单创建成功"];
        
                IWMeShouHouResultVC *payVC = [[IWMeShouHouResultVC alloc]init];
        
#warning 0419
        payVC.needPOPToRootIndex = 3;
        payVC.dataDic = data;
        
                [self.navigationController pushViewController:payVC animated:YES];
        
        
    } failure:^(NSError *error) {
        [[ASingleton shareInstance] stopLoadingView];
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"订单创建失败"];
    }];
    
}
#pragma mark 头部高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kFRate(38);
}
#pragma mark 头部视图生成
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, kViewWidth, kFRate(38))];
    nameLabel.font = kFont28px;
    nameLabel.textColor = kColorSting(@"666666");
    nameLabel.backgroundColor = kColorRGB(240, 240, 240);
    nameLabel.text = @"   选择商品退换数量";
    return nameLabel;
}

#pragma mark - 退换类型选择
-(void)selectClass:(UIGestureRecognizer *)tap{
    self.pickerView.hidden = NO;
    self.mobanView.hidden = NO;
}

-(UIPickerView *)pickerView{
    if (!_pickerView) {
        // 选择框
        UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, kViewHeight - 200, kViewWidth, 200)];
        pickerView.backgroundColor = [UIColor lightGrayColor];
        // 显示选中框
        pickerView.showsSelectionIndicator=YES;
        pickerView.dataSource = self;
        pickerView.delegate = self;
        _pickerView = pickerView;
        
        UIView *mobanView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kViewWidth, kViewHeight - 200)];
        mobanView.backgroundColor = [UIColor clearColor];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeMoban)];
        [mobanView  addGestureRecognizer:tap];
        
        [self.view addSubview:mobanView];
        self.mobanView = mobanView;
        
        [self.view addSubview:pickerView];
    }
    return _pickerView;
}

-(void)removeMoban{
    self.pickerView.hidden = YES;
    self.mobanView.hidden = YES;
    
}
// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.pickerList count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return  [self.pickerList objectAtIndex:row];
}
// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSString  *pickerListStr = [self.pickerList objectAtIndex:row];
    self.selectLabel.text = pickerListStr;
    self.pickerView.hidden = YES;
    self.mobanView.hidden = YES;
}
#pragma mark 低部高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return kFRate(225);
    
}
#pragma mark 低部
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kViewWidth, 225)];
    footView.backgroundColor = [UIColor whiteColor];
    footView.userInteractionEnabled = YES;
    
    CGFloat labelH = kFRate(38);
    CGFloat labelX = kFRate(10);
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, kViewWidth, labelH)];
    nameLabel.font = kFont28px;
    nameLabel.textColor = kColorSting(@"666666");
    nameLabel.backgroundColor = kColorRGB(240, 240, 240);
    nameLabel.text = @"   问题描述";
    [footView addSubview:nameLabel];
    
    
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetHeight(nameLabel.frame), kViewWidth, labelH)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [footView addSubview:whiteView];
    whiteView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectClass:)];
    [whiteView addGestureRecognizer:tap];
    
    
    UILabel *tuiHuanClassLabel = [[UILabel alloc]initWithFrame:CGRectMake(labelX,0, kFRate(65), kFRate(38))];
    tuiHuanClassLabel.font = kFont28px;
    tuiHuanClassLabel.textColor = kColorSting(@"666666");
    tuiHuanClassLabel.backgroundColor = [UIColor clearColor];
    tuiHuanClassLabel.text = @"退换类型:";
    [whiteView addSubview:tuiHuanClassLabel];
    tuiHuanClassLabel.userInteractionEnabled = YES;
    [tuiHuanClassLabel addGestureRecognizer:tap];
    
    UILabel *selectLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(tuiHuanClassLabel.frame),0,  kFRate(93), kFRate(38))];
    selectLabel.font = kFont28px;
    selectLabel.textColor = [UIColor lightGrayColor];
    selectLabel.backgroundColor = [UIColor whiteColor];
    selectLabel.text = @"请选择";
    [whiteView addSubview:selectLabel];
    self.selectLabel = selectLabel;
    selectLabel.userInteractionEnabled = YES;
    [selectLabel addGestureRecognizer:tap];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(selectLabel.frame) - 0.5, kViewWidth, 0.5)];
    line.backgroundColor = [UIColor HexColorToRedGreenBlue:@"d8d8dd"];
    [whiteView addSubview:line];
    
    // 输入框
    ATextView *textView = [[ATextView alloc] initWithFrame:CGRectMake(0 , CGRectGetMaxY(whiteView.frame), kViewWidth, kFRate(75))];
    textView.font = kFont28px;
    textView.editable = YES;   //是否允许编辑内容，默认为“YES”
    textView.textColor = IWColor(29, 29, 29);
    textView.backgroundColor = kColorRGB(240, 240, 240);
    textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    textView.showsVerticalScrollIndicator = YES;
    textView.placeholder = @"请描述退换货的原因";
    textView.placeholderColor = IWColor(154, 154, 154);
    textView.delegate = self;
    [footView addSubview:textView];
    self.textView = textView;
    
    
    
    CGFloat buttonX = 40;
    CGFloat buttonY = CGRectGetMaxY(textView.frame) + labelH;
    CGFloat buttonW = kViewWidth - 2 * buttonX;
    CGFloat buttonH = 40;
    
    UIButton  *button = [[UIButton alloc]initWithFrame:CGRectMake(buttonX, buttonY, buttonW, buttonH)];
    [button setTitle:@"确认提交" forState:UIControlStateNormal];
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    button.titleLabel.font = kFont28px;
    button.titleLabel.textColor = [UIColor whiteColor];
    [button addTarget:self action:@selector(sure:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = IWColorRed;
    [footView addSubview:button];
    
    return footView;
}
#pragma mark 高度cell
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kFRate(110);
}

#pragma mark 组数量
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
#pragma mark 组内部cell数量
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *tempArray = self.model.children;
    return tempArray.count;
}
#pragma mark 组内部cell实现
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IWMeTuiHuoCell *cell = [IWMeTuiHuoCell cellWithTableView:tableView];
    
    NSArray *tempArray = self.model.children;
    IWMeOrderFormProductModel *model =  tempArray[indexPath.row];
    cell.model = model;
    __weak typeof(self) weakSelf = self;
    
    cell.subBtnClick = ^(IWMeTuiHuoCell * cell){
        NSInteger  count =  [model.countShouHou integerValue];
        if (count > 1) {
            model.countShouHou = [NSString stringWithFormat:@"%d", count - 1];
            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }else{
            [[TKAlertCenter defaultCenter]postAlertWithMessage:@"最少为1件"];
        }
    };
    cell.addBtnClick = ^(IWMeTuiHuoCell * cell){
        NSInteger  count =  [model.countShouHou integerValue];
        NSInteger  countMax =  [model.count integerValue];
        if (count < countMax) {
            model.countShouHou = [NSString stringWithFormat:@"%d", count + 1];
            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }else{
            [[TKAlertCenter defaultCenter]postAlertWithMessage:@"不能超过购买数量"];
        }
        
        [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    };
    return cell;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.mobanView removeFromSuperview];
}

-(void)setModel:(IWMeOrderFormModel *)model{
    _model = model;
    
    //重新赋值 售后的个数
    for (IWMeOrderFormProductModel *productModel in model.children) {
        productModel.countShouHou = [productModel.count mutableCopy];;
    }
    
    
}
@end


