//
//  PEPlayerTableCell.m
//  VideoLive
//
//  Created by petry(陈荣) on 2017/4/14.
//  Copyright © 2017年 petry(陈荣). All rights reserved.
//

#import "PEPlayerTableCell.h"

@interface PEPlayerTableCell()

@property (nonatomic,strong) UIImageView *iconImage;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIButton *address;
@property (nonatomic,strong) UILabel *peopleNumber;
@property (nonatomic,strong) UIImageView *coverImage;
@property (nonatomic,strong) UIButton *liveBtn;
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) UIView *backView;

@end
@implementation PEPlayerTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:0.5];
//        self.backgroundColor = [UIColor orangeColor];
        [self buildPlayerCell];
    }
    return self;
}

- (void)buildPlayerCell
{
    _iconImage = [[UIImageView alloc] init];
    _iconImage.layer.cornerRadius = 25;
    _iconImage.layer.masksToBounds = YES;
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont systemFontOfSize:15];
    
    _address = [[UIButton alloc] init];
    _address.titleLabel.font = [UIFont systemFontOfSize:13];
    [_address setTitle:@"中国" forState:UIControlStateNormal];
    [_address setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_address setImage:[UIImage imageNamed:@"address"] forState:UIControlStateNormal];
    _address.titleLabel.textAlignment = NSTextAlignmentLeft;
    _address.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    _peopleNumber = [[UILabel alloc] init];
    _peopleNumber.text = @"1";
    _peopleNumber.textColor = [UIColor grayColor];
    _peopleNumber.font = [UIFont systemFontOfSize:13];
    _peopleNumber.textAlignment = NSTextAlignmentRight;
    
    _coverImage = [[UIImageView alloc] init];
    _coverImage.contentMode = UIViewContentModeScaleAspectFill;
    
    _liveBtn = [[UIButton alloc] init];
    _liveBtn.layer.cornerRadius = 12;
    _liveBtn.layer.masksToBounds = YES;
    _liveBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_liveBtn setTitle:@"直播" forState:UIControlStateNormal];
    [_liveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _liveBtn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = [UIColor darkGrayColor];
    _lineView.alpha = 0.5;
    
    _backView = [[UIView alloc] init];
    _backView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:_backView];
    [self addSubview:_iconImage];
    [self addSubview:_nameLabel];
    [self addSubview:_address];
    [self addSubview:_peopleNumber];
    [self addSubview:_coverImage];
    [self addSubview:_liveBtn];
    [self addSubview:_lineView];
    
    
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@50);
        make.leading.equalTo(@10);
        make.top.equalTo(@10);
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_iconImage.mas_trailing).offset(10);
        make.trailing.equalTo(self);
        make.height.equalTo(@20);
        make.top.equalTo(@15);
    }];
    [_address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom).offset(5);
        make.trailing.equalTo(@-150);
        make.leading.equalTo(_nameLabel);
        make.height.equalTo(@10);
    }];
    [_peopleNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_address);
        make.leading.equalTo(_iconImage.mas_trailing).offset(10);
        make.height.equalTo(@10);
        make.trailing.equalTo(self).offset(-10);
    }];
    [_coverImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconImage.mas_bottom).offset(5);
        make.width.equalTo(self);
        make.bottom.equalTo(self).offset(-20);
    }];
    [_liveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_coverImage.mas_top).offset(10);
        make.trailing.equalTo(_coverImage).offset(-10);
        make.width.equalTo(@45);
        make.height.equalTo(@22);
    }];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self);
        make.height.equalTo(@1);
        make.top.equalTo(_coverImage.mas_bottom);
    }];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self);
        make.bottom.equalTo(_lineView);
    }];
    
    
}

- (void)setPlayerModel:(PEPlayerModel *)playerModel
{
    _playerModel = playerModel;
    _nameLabel.text = playerModel.name;
    [_address setTitle:@"仙境" forState:UIControlStateNormal];
    if (![playerModel.city isEqualToString:@""]) {
        [_address setTitle:playerModel.city forState:UIControlStateNormal];
    }
    [_iconImage sd_setImageWithURL:[NSURL URLWithString:playerModel.portrait]];
    [_coverImage sd_setImageWithURL:[NSURL URLWithString:playerModel.portrait] placeholderImage:[UIImage imageNamed:@"liveRoom"]];
    _peopleNumber.text = [NSString stringWithFormat:@"%d人正在观看",playerModel.online_users];
    
}

@end
