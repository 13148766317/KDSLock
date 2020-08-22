//
//  AddressCell.m
//  rent
//
//  Created by David on 16/5/9.
//  Copyright © 2016年 whb. All rights reserved.
//

#import "AddressCell.h"

@implementation AddressCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.leftLabel =[[UILabel alloc]initWithFrame:CGRectMake(15, (49 -30)/2, 90, 30)];
        self.leftLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"#525252"]; // #272727
        self.leftLabel.font =[UIFont systemFontOfSize:16];
        self.leftLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.leftLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
