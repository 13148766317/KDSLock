//
//  KDSSpreadCell.m
//  kaadas
//
//  Created by 中软云 on 2019/7/1.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSSpreadCell.h"

@interface KDSSpreadCell ()
@property (nonatomic,strong)UIImageView * spreadImageView;
@end

@implementation KDSSpreadCell

-(void)buttonClick{
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImage * image = [UIImage imageNamed:@"banner4_mine"];
        _spreadImageView = [[UIImageView alloc]init];
        _spreadImageView.userInteractionEnabled = YES;
        _spreadImageView.image = image;
        [self.contentView addSubview:_spreadImageView];
        
        CGFloat spreadHeight = KSCREENWIDTH * image.size.height / image.size.width;
        
        [_spreadImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(self.contentView);
            make.height.mas_equalTo(spreadHeight);
        }];
        
//        CGFloat buttonH = 27;
//        JXLayoutButton * button = [JXLayoutButton buttonWithType:UIButtonTypeCustom];
//        button.midSpacing = 5;
//        button.layoutStyle = JXLayoutButtonStyleLeftTitleRightImage;
//        [button setTitle:@"我要推广" forState:UIControlStateNormal];
//        button.titleLabel.font = [UIFont systemFontOfSize:15];
//        button.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#692629"];
//        [button setImage:[UIImage imageNamed:@"icon_list_more_white"] forState:UIControlStateNormal];
//        button.layer.cornerRadius = buttonH / 2;
//        [_spreadImageView addSubview:button];
//        [button addTarget:self action:@selector(spreadButtonClick) forControlEvents:UIControlEventTouchUpInside];
//        [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
//        [button mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.size.mas_equalTo(CGSizeMake(100, buttonH));
//            make.centerX.mas_equalTo(self.spreadImageView.mas_centerX);
//            make.bottom.mas_equalTo(-(spreadHeight / 2 - 6 - buttonH)/2);
//        }];
        
        UIView * dividing = [KDSMallTool createDividingLineWithColorstring:@"f7f7f7"];
        [self.contentView addSubview:dividing];
        [dividing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.spreadImageView.mas_bottom);
            make.height.mas_equalTo(15);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).priorityLow();
        }];
        
    }
    return self;
}

-(void)spreadButtonClick{
    if ([_delegate respondsToSelector:@selector(spreadCellButtonClick)]) {
        [_delegate spreadCellButtonClick];
    }
}

+(instancetype)spreadCellWithTableView:(UITableView *)tableView{
    static NSString * cellID = @"KDSSpreadCellID";
    KDSSpreadCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

@end
