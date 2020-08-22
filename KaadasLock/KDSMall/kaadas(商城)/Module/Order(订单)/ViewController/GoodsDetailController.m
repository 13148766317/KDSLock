//
//  GoodsDetailController.m
//  kaadas
//
//  Created by Apple on 2019/5/22.
//  Copyright © 2019年 kaadas. All rights reserved.
//

#import "GoodsDetailController.h"
#import "UIButton+NSString.h"
#import "DetailModel.h"
#define MaskColor [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3]

@interface GoodsDetailController (){
    NSInteger buyNum;
    UILabel *priceLab;
    UILabel *storeLab;
    UIImageView *picV;
    DetailModel *selectModel;
   
}
@property(nonatomic,strong)UIScrollView *myscrollView;
@property(nonatomic,strong) UILabel* numCountLab;
@property(nonatomic,strong) NSMutableArray* btnArr;


@end

@implementation GoodsDetailController


-(void)dismiss{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

-(void)addBottomBtn:(NSArray *)typeArr{
    NSMutableArray *arr = [NSMutableArray array];
    
    CGFloat bgViewHeight = 60.0f;
    UIView  * bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(KSCREENWIDTH, bgViewHeight));
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
    
    
    CGFloat buttonHeight = 49.0f;
    CGFloat buttonX      = typeArr.count == 1 ? 30.0f : 30.0f;
    CGFloat buttonWidth = (KSCREENWIDTH - 2 * buttonX) / typeArr.count;;
    for (int i = 0; i < typeArr.count; i ++) {
        UIButton *Btn= [UIButton buttonWithType:UIButtonTypeCustom];
        [Btn setTitle:typeArr[i] forState:UIControlStateNormal];
        Btn.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#ca2128"];
        [Btn setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
        Btn.titleLabel.font = [UIFont systemFontOfSize:18];
        [Btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        Btn.idString = typeArr[i];
        [bgView addSubview:Btn];
        [arr addObject:Btn];

        [Btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0).mas_offset(buttonX + i * buttonWidth);
            make.size.mas_equalTo(CGSizeMake(buttonWidth, buttonHeight));
            make.top.mas_equalTo(bgView.mas_top);
        }];
        
        
        if (typeArr.count == 1) {
            Btn.layer.cornerRadius = buttonHeight / 2;
            Btn.layer.masksToBounds = YES;
            Btn.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#1F96F7"];
            [Btn setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
            return;
        }
        
        if (i == typeArr.count -1) {
            Btn.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#1F96F7"];
            [Btn setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];

            UIBezierPath * maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, buttonWidth, buttonHeight) byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(buttonWidth, buttonHeight)];
            CAShapeLayer * maskLayer = [[CAShapeLayer alloc]init];
            maskLayer.frame = CGRectMake(0, 0, buttonWidth, buttonHeight);
            maskLayer.path = maskPath.CGPath;
            Btn.layer.mask = maskLayer;
        }
        else{
            Btn.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#56B3FF"];
            [Btn setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
            UIBezierPath * maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, buttonWidth, buttonHeight) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(buttonWidth, buttonHeight)];
            CAShapeLayer * maskLayer = [[CAShapeLayer alloc]init];
            maskLayer.frame = CGRectMake(0, 0, buttonWidth, buttonHeight);
            maskLayer.path = maskPath.CGPath;
            Btn.layer.mask = maskLayer;
        }

    }
    
//    if (arr.count >=2 ) {
//        NSInteger padding = 0;
//        [arr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:padding leadSpacing:padding tailSpacing:padding];
//        [arr mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-0);
//            make.height.mas_equalTo(50);
//        }];
//    }
   
    
}

-(instancetype)init{
    if (self = [super init]) {
        _residueNum = 99;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"视图加载");
    NSLog(@"contentH=%f" ,self.contentH);
    self.view.backgroundColor = [UIColor whiteColor];

    picV= [[UIImageView alloc]init];
    picV.backgroundColor = KViewBackGroundColor;
    [self.view addSubview:picV];
    [picV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(-15);
        make.size.mas_equalTo(CGSizeMake(110, 110));
    }];

    priceLab = [[UILabel alloc]init];
    priceLab.text = @"¥0";
    priceLab.textColor = [UIColor hx_colorWithHexRGBAString:@"#ca2128"];
    priceLab.textAlignment = NSTextAlignmentLeft;
    priceLab.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:priceLab];
    [priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(picV.mas_right).mas_offset(15);
        make.top.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(130, 15));
    }];

    storeLab = [[UILabel alloc]init];
    //    storeLab.text = @"库存7502件";
    storeLab.textColor = [UIColor hx_colorWithHexRGBAString:@"#666666"];
    storeLab.numberOfLines = 2;
    storeLab.textAlignment = NSTextAlignmentLeft;
    storeLab.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:storeLab];
    [storeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(picV.mas_right).mas_offset(15);
        make.top.mas_equalTo(priceLab.mas_bottom).mas_offset(15);
        //        make.size.mas_equalTo(CGSizeMake(130, 15));
        make.right.mas_equalTo(-10);
    }];

    UILabel* colorLab = [[UILabel alloc]init];
    //    colorLab.text = @"请选择饰面颜色";
    colorLab.textColor = [UIColor hx_colorWithHexRGBAString:@"#666666"];
    colorLab.textAlignment = NSTextAlignmentLeft;
    colorLab.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:colorLab];
    [colorLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(picV.mas_right).mas_offset(15);
        make.top.mas_equalTo(storeLab.mas_bottom).mas_offset(15);
        make.size.mas_equalTo(CGSizeMake(130, 15));
    }];


    UIButton *removeBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    [removeBtn setImage:[UIImage imageNamed:@"icon_norms_del"] forState:UIControlStateNormal];
    [removeBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:removeBtn];
    [removeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];

    UILabel *topL = [[UILabel alloc]init];
    topL.backgroundColor = KViewBackGroundColor;
    [self.view addSubview:topL];
    [topL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(picV.mas_bottom).mas_offset(15);
        make.height.mas_equalTo(1);
    }];


    self.myscrollView = [[UIScrollView alloc] init];
    self.myscrollView.frame = CGRectMake(0, 111, KSCREENWIDTH, self.contentH-111);
    [self.view addSubview:self.myscrollView];

    self.contentView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, self.contentH-100)];
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.myscrollView addSubview:self.contentView];
    self.myscrollView.contentInset =UIEdgeInsetsMake(0, 0, 0, 0);

    UILabel* colorTitLab = [[UILabel alloc]init];
    colorTitLab.text = @"产品组合";
    colorTitLab.textColor = [UIColor hx_colorWithHexRGBAString:@"#666666"];
    colorTitLab.textAlignment = NSTextAlignmentLeft;
    colorTitLab.font = [UIFont systemFontOfSize:18];
    [self.contentView addSubview:colorTitLab];
    [colorTitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(10).mas_offset(30);
        make.size.mas_equalTo(CGSizeMake(130, 18));
    }];


    CGFloat Start_X = 15; //第一个按钮的X坐标
    CGFloat Start_Y = 20; //第一个按钮的Y坐标
    CGFloat wSpace = 15; //按钮横间距
    CGFloat hSpace = 15; //按钮横竖间距
    CGFloat btnW = (KSCREENWIDTH-45)/2; //按钮宽
    CGFloat btnH = 33; //按钮高


    self.btnArr = [NSMutableArray array];
    UIButton *lastBtn;
    //    NSArray *array = @[@"曜石黑+全国包装安装+三年质保",@"玫瑰金+全国包装安装+三年质保",@"土豪金+全国包装安装+三年质保",@"粉色金+全国包装安装+三年质保",@"钻石+全国包装安装+三年质保",@"超大屏+全国包装安装+三年质保",@"vivoX9柔光双色,照亮你的美"];
    for (int i = 0; i < self.dataArray.count ; i ++) {
        DetailModel *model = self.dataArray[i];
        UIButton *Btn= [UIButton buttonWithType:UIButtonTypeCustom];
        [Btn setTitle:[NSString stringWithFormat:@"%@" ,model.attributeComboName] forState:UIControlStateNormal];
        Btn.backgroundColor = KViewBackGroundColor;
        [Btn setTitleColor: [UIColor hx_colorWithHexRGBAString:@"#333333"] forState:UIControlStateNormal];
        Btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [Btn addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
        Btn.tag = 1000+i;
        [self.contentView addSubview:Btn];

        NSInteger index = i % 2;
        NSInteger page = i / 2;
        [Btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).mas_offset(index * (btnW + wSpace) + Start_X);
            make.top.mas_equalTo(colorTitLab.mas_bottom).mas_offset(page  * (btnH + hSpace)+Start_Y);
            make.size.mas_equalTo(CGSizeMake(btnW, btnH));
        }];

        //        if ( i ==0) {
        //            Btn.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#333333"];
        //            [Btn setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
        //        }
        if ( i==self.dataArray.count -1) {
            lastBtn = Btn;
        }
        [self.btnArr addObject:Btn];
    }

    UILabel *midL = [[UILabel alloc]init];
    midL.backgroundColor = KViewBackGroundColor;
    [self.contentView addSubview:midL];
    [midL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(lastBtn.mas_bottom).mas_offset(17);
        make.height.mas_equalTo(1);
    }];



    UILabel* numLab = [[UILabel alloc]init];
    numLab.text = @"购买数量";
    numLab.textColor = [UIColor hx_colorWithHexRGBAString:@"#666666"];
    numLab.textAlignment = NSTextAlignmentLeft;
    numLab.font = [UIFont systemFontOfSize:18];
    [self.contentView addSubview:numLab];
    [numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(midL.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(130, 59));
    }];


    UIButton * addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.backgroundColor = [UIColor cyanColor];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    addBtn.tag = 12;
    [addBtn setTitle:@"+" forState:UIControlStateNormal];
    addBtn.backgroundColor = KViewBackGroundColor;
    [addBtn setTitleColor: [UIColor hx_colorWithHexRGBAString:@"#666666"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(numBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview: addBtn];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(midL.mas_bottom).mas_offset(15);
        make.right.mas_equalTo(-15);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];


    self.numCountLab = [[UILabel alloc]init];
    self.numCountLab.font = [UIFont systemFontOfSize:15];
    self.numCountLab.textColor =[UIColor hx_colorWithHexRGBAString:@"#333333"];
    self.numCountLab.textAlignment = NSTextAlignmentCenter;
    self.numCountLab.backgroundColor=KViewBackGroundColor;
    [self.contentView addSubview:  self.numCountLab];
    [ self.numCountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(midL.mas_bottom).mas_offset(15);
        make.right.mas_equalTo(addBtn.mas_left).mas_offset(-2);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
    buyNum = 1;
    self.numCountLab.text =[NSString stringWithFormat:@"%ld" ,(long)buyNum];


    UIButton * deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteBtn setTitle:@"-" forState:UIControlStateNormal];
    deleteBtn.tag = 11;
    deleteBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    deleteBtn.backgroundColor = KViewBackGroundColor;
    [deleteBtn setTitleColor: [UIColor hx_colorWithHexRGBAString:@"#666666"] forState:UIControlStateNormal];
    [ deleteBtn addTarget:self action:@selector(numBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview: deleteBtn];
    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(midL.mas_bottom).mas_offset(15);
        make.right.mas_equalTo( self.numCountLab.mas_left).mas_offset(-2);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];

    UILabel *botL = [[UILabel alloc]init];
    botL.backgroundColor = KViewBackGroundColor;
    [self.contentView addSubview:botL];
    [botL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(numLab.mas_bottom);
        make.height.mas_equalTo(1);
    }];


    UILabel* serverLab = [[UILabel alloc]init];
    serverLab.text = @"特色服务";
    serverLab.textColor = [UIColor hx_colorWithHexRGBAString:@"#666666"];
    serverLab.textAlignment = NSTextAlignmentLeft;
    serverLab.font = [UIFont systemFontOfSize:18];
    [self.contentView addSubview:serverLab];
    [serverLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(botL.mas_bottom).mas_offset(30);
        make.size.mas_equalTo(CGSizeMake(130, 18));
    }];


    UILabel *lastLab;
    NSArray *serArray = @[@"上门安装 (商家赠送)"];
    for (int i = 0; i < serArray.count ; i ++) {
        UILabel *lab= [[UILabel alloc]init];
        lab.font = [UIFont systemFontOfSize:12];
        lab.text = serArray[i];
        lab.textColor = [UIColor hx_colorWithHexRGBAString:@"#333333"];
        [self.contentView addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(serverLab.mas_bottom).mas_offset(20+i*30);
            make.size.mas_equalTo(CGSizeMake(200, 20));
        }];
        if ( i==serArray.count -1) {
            lastLab = lab;
        }

        //        NSString *priceS=[NSString stringWithFormat:@"¥%@" ,detailModel.price];
        //        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:priceS];
        //        [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 1)];
        //        self.priceLab.attributedText = AttributedStr;
    }

    UIButton *serverBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    [serverBtn setImage:[UIImage imageNamed:@"产品选中"] forState:UIControlStateSelected];
    [serverBtn setImage:[UIImage imageNamed:@"产品未选中"] forState:UIControlStateNormal];
    [serverBtn addTarget:self action:@selector(serverClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:serverBtn];
    [serverBtn setSelected:YES];

    [serverBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(serverLab.mas_bottom).mas_offset(5);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];


    NSLog(@"yyy===%f" ,lastLab.frame.origin.y);
    [self.contentView layoutIfNeeded];
    NSLog(@"yyy===%f" ,lastLab.frame.origin.y);


    CGFloat botBtnH = 50;
    CGFloat totalH = 0+lastLab.frame.origin.y+lastLab.frame.size.height+0+botBtnH;

    self.contentView.frame = CGRectMake(0, 0, KSCREENWIDTH, totalH+99);
    self.myscrollView .contentSize = CGSizeMake(KSCREENWIDTH, totalH+47);

    switch (_type) {
        case KDSProductDetail_noraml:{
            [self addBottomBtn:@[@"加入购物车",@"立即购买"]];
        }
            break;
        case KDSProductDetail_seckill:{
            [self addBottomBtn:@[@"立即抢购"]];
        }
            break;
        case KDSProductDetail_group:{
            [self addBottomBtn:@[@"立即购买"]];
        }
            break;
        case KDSProductDetail_crowdfunding:{
            [self addBottomBtn:@[@"加入购物车",@"立即购买"]];
        }
            break;
        case KDSProductDetail_bargain:{
            [self addBottomBtn:@[@"发起砍价"]];
        }
            break;
        default:
            break;
    }

    UIButton *find = [self.view viewWithTag:1000];
    [self selectClick:find];

}

-(void)selectClick:(UIButton *)sender{
    for (UIButton *btn in self.btnArr) {
        if ([btn isEqual:sender]) {
            btn.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#56B3FF"];
            [btn setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
        }else{
            btn.backgroundColor = KViewBackGroundColor;
            [btn setTitleColor: [UIColor hx_colorWithHexRGBAString:@"#333333"] forState:UIControlStateNormal];
        }
    }
    
    selectModel = self.dataArray[sender.tag-1000];
    
    [picV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@" ,selectModel.logo]] placeholderImage:[UIImage imageNamed:@"图片占位"]];
    NSString * priceString = [NSString stringWithFormat:@"¥%@" ,selectModel.price];
    priceLab.attributedText = [KDSMallTool attributedString:priceString dict:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} range:NSMakeRange(0, 1) lineSpacing:0];
//    storeLab.text =[NSString stringWithFormat:@"库存%@件" ,selectModel.realQty];
//    storeLab.text = [NSString stringWithFormat:@"%@",selectModel.skuName];
 
    if (self.selectBlock) {
        self.selectBlock(selectModel);
    }
}

-(void)btnClick:(UIButton *)sender{
    
    selectModel.qty = [NSString stringWithFormat:@"%ld" ,(long)buyNum];

    NSInteger index = 0; //0购物车 1 立即购买
    
    if ([sender.idString isEqualToString:@"立即购买"]) {
        index = 1;
        NSLog(@"立即购买");
    }
    
    if (self.selBlock) {
        self.selBlock(selectModel ,index);
    }
    [self dismiss];
    
}


-(void)numBtnAction:(UIButton *)sender{
    
    NSInteger flag = sender.tag;
    switch (flag) {
        case 11:{
            if (buyNum > 1)
            {
               
               buyNum --;
            }
        }
            break;
        case 12:
        {
            if (buyNum >= _residueNum) {
                [KDSProgressHUD showFailure:[NSString stringWithFormat:@"你已经超过最大购买数量!"] toView:nil completion:^{}];
                return;
            }
            buyNum ++;
        }
            break;
            
        default:
            
            break;
    }
    
    self.numCountLab.text =[NSString stringWithFormat:@"%ld" ,(long)buyNum];
    
}

-(void)serverClick:(UIButton *)sender{
    sender.selected = !sender.selected;
}


@end
