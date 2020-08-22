//
//  KDSProductEvaluteCell.m
//  kaadas
//
//  Created by 中软云 on 2019/5/21.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSProductEvaluteCell.h"
#import "KDSProductEvaluteBottomView.h"


//图片最大个数
static int maxImageViewCount = 3;

@interface KDSProductEvaluteCell ()
<
KDSProductBottomViewDelegate
>
//分割线
@property(nonatomic,strong)UIView           * boldDividing;
//头像
@property (nonatomic,strong)UIImageView   * iconImageView;
//昵称
@property (nonatomic,strong)UILabel       * nickLabel;
//时间
@property (nonatomic,strong)UILabel       * timeLabel;
//产品样式
@property (nonatomic,strong)UILabel       * productStyeLb;
//内容
@property (nonatomic,strong)UILabel       * contentLabel;
// 观看量   评论 点赞
@property (nonatomic,strong)KDSProductEvaluteBottomView   * bottomView;
//@property (nonatomic,strong)UIView   * b;

@property (nonatomic,strong)NSMutableArray   * imageViewArray;
@end

@implementation KDSProductEvaluteCell

-(void)setHiddenBoldDividing:(BOOL)hiddenBoldDividing{
    _hiddenBoldDividing = hiddenBoldDividing;
    if (_hiddenBoldDividing) {
        [_boldDividing mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(0);
            make.left.right.mas_equalTo(self.contentView);
        }];
    }
}


#pragma mark -  图片点击事件
-(void)imageviewtap:(UITapGestureRecognizer *)tap{
    if ([_delegate respondsToSelector:@selector(evaluateCellImageViewClick:imageIndex:imageViewArray:)]) {
        NSMutableArray * imageViewArray = [NSMutableArray array];
        NSInteger  count = _rowModel.urls.count;
        for (int i = 0; i<count; i++) {
            UIImageView * imageView = _imageViewArray[i];
            [imageViewArray addObject:imageView];
        }
        [_delegate evaluateCellImageViewClick:_indexPath imageIndex:tap.view.tag imageViewArray:_imageViewArray];
    }
}
-(void)setCount:(NSInteger)count{
    _count = count;
    if (_count <= 0) {//如果没有展示图
        for (UITableView * imageView in _imageViewArray) {
            imageView.hidden = YES;
        }
        [_bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(0);
            make.top.mas_equalTo(self.contentLabel.mas_bottom).mas_offset(20);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).priorityLow();
        }];
    }else{//有展示图
        //列数
        NSUInteger column = 3;
        //每个imageview之间的间隔
        CGFloat imageviewMargin = 5;
        //宽
        CGFloat imageviewW = (KSCREENWIDTH -  2 * 15 - (column - 1) * imageviewMargin) / column;
        //高
        CGFloat imageviewH = imageviewW;
        
        for (int i = 0; i < maxImageViewCount; i++) {
            UIImageView * imageView = _imageViewArray[i];
            //行号
            int row = i / column;
            //列号
            int col = i % column;
            
            if (_count > i) {
                //            QZPhotoTextVideoImageModel * imageModel  = imageList[i];
                imageView.hidden = NO;
                //            [imageView sd_setImageWithURL:[NSURL URLWithString:[QZTool checkISNull:imageModel.imgUrl]] placeholderImage:[UIImage imageNamed:placeholder_w]];
                [imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(0).mas_offset(15 + col * (imageviewMargin + imageviewW));
                    make.top.mas_equalTo(self.contentLabel.mas_bottom).mas_offset(10 +  row * (imageviewMargin + imageviewH));
                    make.size.mas_equalTo(CGSizeMake(imageviewW, imageviewH));
                }];
            }else{
                imageView.hidden = YES;
            }
        }
        
        UIImageView * lastImageView = [_imageViewArray firstObject];
        [_bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(lastImageView.mas_bottom).mas_offset(20);
            make.height.mas_equalTo(0);
             make.bottom.mas_equalTo(self.contentView.mas_bottom).priorityLow();
        }];
    }
    

}
#pragma mark - KDSProductBottomViewDelegate
-(void)productEvaluateBottemViewButtonClick:(KDSProductEvaluateButtonType)type{
    switch (type) {
        case KDSProductEvaluate_evaluate:{//评论
            
        }
            break;
        case KDSProductEvaluate_like:{//点赞
            
        }
            break;
            
        default:
            break;
    }
}

-(void)setRowModel:(KDSProductEvaluateRowModel *)rowModel{
    _rowModel = rowModel;
    if ([KDSMallTool checkObjIsNull:_rowModel]) {
        return;
    }
    //头像
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:[KDSMallTool checkISNull:_rowModel.logo]] placeholderImage:[UIImage imageNamed:@"pic_head_list"]];
    //昵称
    _nickLabel.text = [KDSMallTool checkISNull:_rowModel.userName];
    //时间
    _timeLabel.text = [KDSMallTool checkISNull:_rowModel.createDate];
    //产品样式
    _productStyeLb.text = [KDSMallTool checkISNull:_rowModel.productLabels];
    //内容
    _contentLabel.text = [KDSMallTool checkISNull:_rowModel.content];
    
    NSInteger imageCount = _rowModel.urls.count;
    
    if (imageCount <= 0) {//如果没有展示图
        for (UITableView * imageView in _imageViewArray) {
            imageView.hidden = YES;
        }
        [_bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(0);
            make.top.mas_equalTo(self.contentLabel.mas_bottom).mas_offset(20);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).priorityLow();
        }];
        
        
    }else{//有展示图
        //列数
        NSUInteger column = 3;
        //每个imageview之间的间隔
        CGFloat imageviewMargin = 5;
        //宽
        CGFloat imageviewW = (KSCREENWIDTH -  2 * 15 - (column - 1) * imageviewMargin) / column;
        //高
        CGFloat imageviewH = imageviewW;
        
        for (int i = 0; i < maxImageViewCount; i++) {
            UIImageView * imageView = _imageViewArray[i];
            //行号
            int row = i / column;
            //列号
            int col = i % column;
            
            if (imageCount > i) {
                //            QZPhotoTextVideoImageModel * imageModel  = imageList[i];
                imageView.hidden = NO;
                [imageView sd_setImageWithURL:[NSURL URLWithString:[KDSMallTool checkISNull:_rowModel.urls[i]]] placeholderImage:[UIImage imageNamed:placeholder_wh]];
                [imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(0).mas_offset(15 + col * (imageviewMargin + imageviewW));
                    make.top.mas_equalTo(self.contentLabel.mas_bottom).mas_offset(10 +  row * (imageviewMargin + imageviewH));
                    make.size.mas_equalTo(CGSizeMake(imageviewW, imageviewH));
                }];
            }else{
                imageView.hidden = YES;
            }
        }
        
        UIImageView * lastImageView = [_imageViewArray firstObject];
        [_bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(lastImageView.mas_bottom).mas_offset(20);
            make.height.mas_equalTo(0);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).priorityLow();
        }];
    }
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
        
        _boldDividing = [KDSMallTool createDividingLineWithColorstring:@"f7f7f7"];
        [self.contentView addSubview:_boldDividing];
        [_boldDividing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(15);
            make.left.right.mas_equalTo(self.contentView);
        }];
        
        //头像
        CGFloat iconH = 40;
        _iconImageView = [[UIImageView alloc]init];
        _iconImageView.image = [UIImage imageNamed:@"pic_head_list"];
        _iconImageView.layer.cornerRadius = iconH / 2;
        _iconImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:_iconImageView];
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.boldDividing.mas_bottom).mas_offset(10);
            make.left.mas_equalTo(15);
            make.size.mas_equalTo(CGSizeMake(iconH, iconH));
        }];
        
        //昵称
        _nickLabel = [KDSMallTool createLabelString:@"" textColorString:@"#333333" font:16];
        [self.contentView addSubview:_nickLabel];
        [_nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconImageView.mas_right).mas_offset(15);
            make.centerY.mas_equalTo(self.iconImageView.mas_centerY);
        }];
        
        //时间
        _timeLabel = [KDSMallTool createLabelString:@"" textColorString:@"#999999" font:12];
        [self.contentView addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconImageView.mas_left);
            make.top.mas_equalTo(self.iconImageView.mas_bottom).mas_offset(7);
        }];
        
        //产品样式
        _productStyeLb = [KDSMallTool createLabelString:@"" textColorString:@"#999999" font:12];
        [self.contentView addSubview:_productStyeLb];
        [_productStyeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.timeLabel.mas_right).mas_offset(25);
            make.centerY.mas_equalTo(self.timeLabel.mas_centerY);
        }];
        //内容
        _contentLabel = [KDSMallTool createLabelString:@"" textColorString:@"#666666" font:15];
        _contentLabel.numberOfLines = 0;
        [self.contentView addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.timeLabel.mas_bottom).mas_offset(20);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
        }];
        
        //图片控件
        _imageViewArray = [NSMutableArray array];
        for (int i = 0; i < maxImageViewCount; i++) {
            UIImageView * imageView = [[UIImageView alloc]init];
            imageView.tag = i;
            imageView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f7f7f7"];
            imageView.userInteractionEnabled = YES;
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds  = YES;
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageviewtap:)];
            [imageView addGestureRecognizer:tap];
            [self.contentView addSubview:imageView];
            //数组中添加UIImageView
            [_imageViewArray addObject:imageView];
        }
        
        _bottomView = [[KDSProductEvaluteBottomView alloc]init];
        _bottomView.delegate = self;
//        _bottomView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_bottomView];
        
    }
    return self;
}
+(instancetype)productEvaluteCellWithTableView:(UITableView *)tableView{
    static NSString * cellID = @"KDSProductEvaluteCellID";
    KDSProductEvaluteCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}


@end
