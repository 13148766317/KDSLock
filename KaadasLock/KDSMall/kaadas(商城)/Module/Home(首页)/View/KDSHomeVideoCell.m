//
//  KDSHomeVideoCell.m
//  kaadas
//
//  Created by 中软云 on 2019/5/8.
//  Copyright © 2019 kaadas. All rights reserved.
//

#import "KDSHomeVideoCell.h"

@interface KDSHomeVideoCell ()
@property (nonatomic,strong)UIImageView   * videoImageView;
@end

@implementation KDSHomeVideoCell

-(void)setVideoModel:(KDSFirstPartVideoModel *)videoModel{
    _videoModel = videoModel;
    
    NSURL * imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[KDSMallTool checkISNull:_videoModel.logo]]];
    
    [_videoImageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:placeholder_w]];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f7f7f7"];
        
        //
        _videoImageView = [[UIImageView alloc]init];
        
        _videoImageView.contentMode = UIViewContentModeScaleAspectFill;
        _videoImageView.clipsToBounds = YES;
        _videoImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer * imageViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewTapClick)];
        [_videoImageView addGestureRecognizer:imageViewTap];
        
        _videoImageView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"ffffff"];
        [self.contentView addSubview:_videoImageView];
        [_videoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(213);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-5).priorityLow();
        }];

        UIButton * playerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [playerButton setImage:[UIImage imageNamed:@"icon_button_stop"] forState:UIControlStateNormal];
        [playerButton addTarget:self action:@selector(imageViewTapClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:playerButton];
        [playerButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self.videoImageView);
            make.size.mas_equalTo(CGSizeMake(60, 60));
        }];
        
    }
    return self;
}

#pragma mark - 播放点击
-(void)imageViewTapClick{
    if ([_delegate respondsToSelector:@selector(videoTableCellVideoButtonClick:videoIndex:videoView:)]) {
        [_delegate videoTableCellVideoButtonClick:_indexPath videoIndex:0 videoView:_videoImageView];
    }
}

+(instancetype)homeVideoCellWithTableView:(UITableView *)tableView{
    static NSString * cellID = @"KDSHomeVideoCellID";
    KDSHomeVideoCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}


@end
