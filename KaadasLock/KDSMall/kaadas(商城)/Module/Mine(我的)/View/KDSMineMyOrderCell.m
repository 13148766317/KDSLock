//
//  KDSMineMyOrderCell.m
//  kaadas
//
//  Created by 中软云 on 2019/5/9.
//  Copyright © 2019 kaadas. All rights reserved.
// 全部订单

#import "KDSMineMyOrderCell.h"
#import "KDSMineCellHeaderView.h"
#import "KDSOrderButton.h"

@interface KDSMineMyOrderCell ()
@property (nonatomic,strong)KDSMineCellHeaderView   * headerView;
@property (nonatomic,strong)KDSOrderButton   * lastOrderButton;

@end

@implementation KDSMineMyOrderCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"ffffff"];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //
        _headerView = [[KDSMineCellHeaderView alloc]init];
        [_headerView addTarget:self action:@selector(allOrderButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _headerView.text = @"全部订单";
        [self.contentView addSubview:_headerView];
        [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.height.mas_equalTo(50);
        }];
        
        NSArray * imageArray = @[@"icon_pay_mine",@"icon_install_mine",@"icon_evaluation_mine",@"icon_refund_mine"];
        NSArray * titleArray = @[@"待支付",@"待安装",@"待评价",@"退款/售后" ];
        CGFloat buttonWidth = KSCREENWIDTH / imageArray.count;
        CGFloat buttonHeight = 100;
        CGFloat buttonX = 0;
        CGFloat buttonY = 20;
        for (int i = 0; i < titleArray.count; i++) {
            KDSOrderButton * button = [KDSOrderButton buttonWithType:UIButtonTypeCustom];
            [button setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
            [button setTitle:titleArray[i] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:12];
            button.tag = i;
            [button addTarget:self action:@selector(orderButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [button setTitleColor:[UIColor hx_colorWithHexRGBAString:@"#333333"] forState:UIControlStateNormal];
            [self.contentView addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(buttonX).mas_offset(i * buttonWidth);
                make.top.mas_equalTo(self.headerView.mas_bottom).mas_offset(buttonY);
                make.size.mas_equalTo(CGSizeMake(buttonWidth, buttonHeight));
            }];
            if (i == titleArray.count - 1) {
                _lastOrderButton = button;
            }
        }
        
        UIView * dividing = [KDSMallTool createDividingLineWithColorstring:@"f7f7f7"];
        [self.contentView addSubview:dividing];
        [dividing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.lastOrderButton.mas_bottom).mas_offset(0);
            make.height.mas_equalTo(15);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).priorityLow();
        }];
        
    }
    return self;
}
#pragma mark - 全部订单 点击事件
-(void)allOrderButtonClick{
    if ([_delegate respondsToSelector:@selector(mineOrderEventType:)]) {
        [_delegate mineOrderEventType:KDSMyOrderEvent_allOrder];
    }
}

-(void)orderButtonClick:(KDSOrderButton *)button{
    KDSMyOrderEventType  type = -1;
    switch (button.tag) {
        case 0:{//待支付
            type = KDSMyOrderEvent_unPay;
        }
            break;
//        case 1:{//待发货
//            type = KDSMyOrderEvent_unDelivery;
//        }
            break;
        case 1:{//待安装
            type = KDSMyOrderEvent_unInstall;
        }
            break;
        case 2:{//待评价
            type = KDSMyOrderEvent_unEvaluate;
        }
            break;
        case 3:{//退款/售后
            type = KDSMyOrderEvent_refundAfter;
        }
            break;
            
        default:
            break;
    }
    
    if (type < 0) {
        return;
    }
    if ([_delegate respondsToSelector:@selector(mineOrderEventType:)]) {
        [_delegate mineOrderEventType:type];
    }
    
    
}


+(instancetype)mineMyOrderCellWithTableView:(UITableView *)tableView{
    static NSString * cellID = @"KDSMineMyOrderCellID";
    KDSMineMyOrderCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}


@end
