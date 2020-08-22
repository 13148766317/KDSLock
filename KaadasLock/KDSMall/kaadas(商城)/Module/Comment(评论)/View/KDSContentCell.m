//
//  KDSContentCell.m
//  kaadas
//
//  Created by 中软云 on 2019/7/10.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSContentCell.h"
#import "StarEvaluationView.h"
#import "BHPhotoBrowser.h"

@interface KDSContentCell ()<UITextViewDelegate,BHPhotoBrowserDelegate>
//产品图片
@property (nonatomic,strong)UIImageView          * iconImageView;
//产品评分
@property (nonatomic,strong)StarEvaluationView   * productPriceView;
//输入框
@property (nonatomic,strong)UITextView           * textView;
//图片控件
@property (nonatomic,strong)BHPhotoBrowser       * photoBrowser;
//商品符合度
@property (nonatomic,strong)StarEvaluationView   * conformityView;
//配送速度
@property (nonatomic,strong)StarEvaluationView   * distributionSpeedView;
//安装满意度
@property (nonatomic,strong)StarEvaluationView   * nstallationView;
//匿名评价
@property (nonatomic,strong)JXLayoutButton      *  hiddenNickButton;
@end


@implementation KDSContentCell

-(void)setModel:(KDSEvaliateModel *)model{
    _model = model;
    //图片
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:[KDSMallTool checkISNull:_model.logo]] placeholderImage:[UIImage imageNamed:placeholder_wh]];
   //产品评分
    _productPriceView.starCount = _model.productScore;
    _textView.text = _model.content;
    //配图
    _photoBrowser.imageArray = (NSMutableArray *)_model.imageArray;
    //商品符合度
    _conformityView.starCount = _model.conformityScore;
    //配送速度
    _distributionSpeedView.starCount = _model.dispatchingScore;
    //安装满意度
    _nstallationView.starCount = _model.installScore;
    
    if ([_model.isAnonymous isEqualToString:@"true"]) {
        _hiddenNickButton.selected = YES;
    }else{
        _hiddenNickButton.selected = NO;
    }

}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _iconImageView = [[UIImageView alloc]init];
        _iconImageView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#E6E6E6"];
        [self.contentView addSubview:_iconImageView];
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        
        
        //产品评分
        UILabel * productPriceLabel = [KDSMallTool createLabelString:@"产品评分" textColorString:@"#333333" font:15];
        [self.contentView addSubview:productPriceLabel];
        [productPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.iconImageView.mas_centerY);
            make.left.mas_equalTo(self.iconImageView.mas_right).mas_offset(20);
        }];
        
        _productPriceView = [StarEvaluationView evaluationViewWithChooseStarBlock:^(NSUInteger count) {
            _model.productScore = count;
//            [self refreshData];
        }];
       
        [self.contentView addSubview:_productPriceView];
        [_productPriceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(productPriceLabel.mas_right);
            make.size.mas_equalTo(CGSizeMake(200, 45));
            make.centerY.mas_equalTo(self.iconImageView.mas_centerY);
        }];
        
        //分隔线
        UIView * dividingView = [KDSMallTool createDividingLineWithColorstring:dividingCorlor];
        [self.contentView addSubview:dividingView];
        [dividingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(self.iconImageView.mas_bottom).mas_offset(10);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(dividinghHeight);
        }];
        
        //评价输入框
        self.textView = [[UITextView alloc] init];
        self.textView.font = [UIFont systemFontOfSize:15];
        self.textView.delegate = self;
        [self.contentView addSubview:self.textView];
        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(dividingView.mas_bottom).mas_offset(20);
            make.height.mas_equalTo(110);
        }];
        
       [_textView addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        
        
        UILabel *placeHolderLabel = [[UILabel alloc] init];
        placeHolderLabel.text = @"请输入您的评价内容";
        placeHolderLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"#999999"];
    //    [placeHolderLabel sizeToFit];
        [self.textView addSubview:placeHolderLabel];
        placeHolderLabel.font = [UIFont systemFontOfSize:15];
        [self.textView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
        [placeHolderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(self.textView);
            make.height.mas_equalTo(15);
        }];
    
        //图片
        CGFloat photoMargin = 10;
        CGFloat maxCol = 3;
        CGFloat photoWidth = 60;//(KSCREENWIDTH - 20 - photoMargin * (maxCol - 1)) / maxCol;
        _photoBrowser = [[BHPhotoBrowser alloc]init];
        _photoBrowser.addImage = [UIImage imageNamed:@"icon_camera_add"];
        _photoBrowser.delegate = self;
        _photoBrowser.photosMaxCol = maxCol;
        _photoBrowser.photoHeight = photoMargin;
        _photoBrowser.photoWidth = photoWidth;
        _photoBrowser.photoHeight = photoWidth;
        _photoBrowser.imagesMaxCountWhenWillCompose = 3;
        [self.contentView  addSubview:_photoBrowser];
        [_photoBrowser mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(_textView.mas_bottom).mas_offset(20);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(photoWidth);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-300).priorityLow();
        }];
        
        //第二个分隔线
        UIView * secondDividing = [KDSMallTool createDividingLineWithColorstring:dividingCorlor];
        [self.contentView addSubview:secondDividing];
        [secondDividing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.photoBrowser.mas_left);
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(self.photoBrowser.mas_bottom).mas_offset(20);
            make.height.mas_equalTo(dividinghHeight);
        }];
        
        //商品符合度
        UILabel * conformityLabel = [KDSMallTool createLabelString:@"商品符合度" textColorString:@"#333333" font:15];
        [self.contentView addSubview:conformityLabel];
        [conformityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(secondDividing.mas_bottom).mas_offset(27);
            make.size.mas_equalTo(CGSizeMake(80, 25));
        }];
        _conformityView = [StarEvaluationView evaluationViewWithChooseStarBlock:^(NSUInteger count) {
            _model.conformityScore = count;
//            [self refreshData];
        }];
        [self.contentView addSubview:_conformityView];
        [_conformityView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(conformityLabel.mas_right).mas_offset(25);
            make.size.mas_equalTo(CGSizeMake(200, 45));
            make.centerY.mas_equalTo(conformityLabel.mas_centerY);
        }];
        //配送速度
        UILabel * distributionSpeedLabel = [KDSMallTool createLabelString:@"配送速度" textColorString:@"#333333" font:15];
        [self.contentView addSubview:distributionSpeedLabel];
        [distributionSpeedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(conformityLabel);
            make.left.mas_equalTo(conformityLabel.mas_left);
            make.top.mas_equalTo(conformityLabel.mas_bottom).mas_offset(30);
        }];
        _distributionSpeedView = [StarEvaluationView evaluationViewWithChooseStarBlock:^(NSUInteger count) {
            _model.dispatchingScore = count;
//            [self refreshData];
        }];
        [self.contentView addSubview:_distributionSpeedView];
        [_distributionSpeedView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.conformityView.mas_left);
            make.centerY.mas_equalTo(distributionSpeedLabel.mas_centerY);
            make.size.mas_equalTo(self.conformityView);
        }];
        
        //安装满意度
        UILabel * nstallationLabel = [KDSMallTool createLabelString:@"安装满意度" textColorString:@"#333333" font:15];
        [self.contentView addSubview:nstallationLabel];
        [nstallationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(distributionSpeedLabel.mas_left);
            make.top.mas_equalTo(distributionSpeedLabel.mas_bottom).mas_offset(30);
            make.size.mas_equalTo(distributionSpeedLabel);
        }];
        _nstallationView = [StarEvaluationView evaluationViewWithChooseStarBlock:^(NSUInteger count) {
            _model.installScore = count;
//            [self refreshData];
        }];
        [self.contentView addSubview:_nstallationView];
        [_nstallationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.distributionSpeedView.mas_left);
            make.centerY.mas_equalTo(nstallationLabel.mas_centerY);
            make.size.mas_equalTo(self.distributionSpeedView);
        }];
        
        //匿名评价
        _hiddenNickButton = [JXLayoutButton buttonWithType:UIButtonTypeCustom];
        _hiddenNickButton.selected = YES;
        _hiddenNickButton.layoutStyle = JXLayoutButtonStyleLeftImageRightTitle;
        _hiddenNickButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_hiddenNickButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#333333"] forState:UIControlStateNormal];
        [_hiddenNickButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#333333"] forState:UIControlStateSelected];
        [_hiddenNickButton setTitle:@"匿名评价" forState:UIControlStateNormal];
        [_hiddenNickButton setTitle:@"匿名评价" forState:UIControlStateSelected];
        [_hiddenNickButton setImage:[UIImage imageNamed:@"产品未选中"] forState:UIControlStateNormal];
        [_hiddenNickButton setImage:[UIImage imageNamed:@"selectbox_select"] forState:UIControlStateSelected];
        _hiddenNickButton.midSpacing = 5;
        [_hiddenNickButton addTarget:self action:@selector(hiddenNickNameButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_hiddenNickButton];
        [_hiddenNickButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(85, 30));
            make.top.mas_equalTo(self.nstallationView.mas_bottom).mas_offset(20);
        }];
        
        UIView * bottomBoldDividing = [KDSMallTool createDividingLineWithColorstring:@"#F7F7F7"];
        [self.contentView addSubview:bottomBoldDividing];
        [bottomBoldDividing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.hiddenNickButton.mas_bottom).mas_offset(10);
            make.height.mas_equalTo(15);
        }];
        
    }
    return self;
}
- (void)textViewDidChange:(UITextView *)textView {
    _model.content = textView.text;
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"text"]) {
        
    }
}

#pragma mark - BHPhotoBrowserDelegate
-(void)photoBrowserImageArray:(NSArray *)imageArray{
    _model.imageArray = imageArray;
//    [self refreshData];
}

//#pragma mark -
//-(void)refreshData{
//    NSLog(@"-------");
//
//    if ([_delegate respondsToSelector:@selector(contentCellDelegateWithModel:indexPath:)]) {
//        [_delegate contentCellDelegateWithModel:_model indexPath:_indexPath];
//        NSLog(@"++++++++++++");
//    }
//}


-(void)hiddenNickNameButtonClick{
    _hiddenNickButton.selected = !_hiddenNickButton.selected;
    if (_hiddenNickButton.selected) {
        _model.isAnonymous = @"true";
    }else{
        _model.isAnonymous = @"false";
    }
//    [self refreshData];
}

+(instancetype)contentCellWithTableView:(UITableView *)tableView{
    static NSString * cellID = @"KDSContentCellID";
    KDSContentCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}


- (void)dealloc
{
    [_textView removeObserver:self forKeyPath:@"text"];
}
@end
