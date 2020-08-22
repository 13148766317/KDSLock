//
//  KDSMyFootprintHeaderView.m
//  kaadas
//
//  Created by 中软云 on 2019/5/14.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSMyFootprintHeaderView.h"

@interface KDSMyFootprintHeaderView ()
@property (nonatomic,strong)UILabel   * timeLb;
@end

@implementation KDSMyFootprintHeaderView


-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#f7f7f7"];
        
        _timeLb = [KDSMallTool createbBoldLabelString:@"" textColorString:@"#333333" font:18];
        [self.contentView addSubview:_timeLb];
        [_timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(19);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-14).priorityLow();
        }];
        
    }
    return self;
}

+(instancetype)myFootPrintHeaderViewWithTableView:(UITableView *)tableView{
    static NSString * headerViewID  = @"KDSMyFootprintHeaderViewID";
    KDSMyFootprintHeaderView * headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerViewID];
    if (headerView == nil) {
        headerView = [[self alloc]initWithReuseIdentifier:headerViewID];
    }
    return headerView;
}

-(void)setDataString:(NSString *)dataString{
    _dataString = dataString;
    
    _timeLb.text = [KDSMallTool checkISNull:_dataString];
}

@end
