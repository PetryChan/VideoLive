//
//  PEProfileCell.m
//  VideoLive
//
//  Created by petry(陈荣) on 2017/4/12.
//  Copyright © 2017年 petry(陈荣). All rights reserved.
//

#import "PEProfileCell.h"
#import "PEProfileCellArrowModel.h"


@interface PEProfileCell()

/** <#description#>  */
@property (nonatomic,weak) UIButton *userIconBtn;
/** <#description#>  */
@property (nonatomic,weak) UILabel *rightLabel;
/** <#description#>  */
@property (nonatomic,weak) UIView *buttomLineView;

@end
@implementation PEProfileCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIButton *btn = [[UIButton alloc] init];
        self.userIconBtn = btn;
        
        UIView *buttomLineView = [[UIView alloc] init];
        self.buttomLineView = buttomLineView;
        buttomLineView.hidden = NO;
        buttomLineView.alpha = 0.5;
        buttomLineView.backgroundColor = [UIColor grayColor];
        [self addSubview:buttomLineView];
        
        UILabel *label = [[UILabel alloc] init];
        self.rightLabel = label;
        [label setFont:[UIFont systemFontOfSize:14]];
        [label setTextColor:[UIColor colorWithWhite:0.5 alpha:1.0]];
        
    }
    
    return self;
}

- (void)setCellModel:(PEProfileCellModel *)cellModel
{
    _cellModel = cellModel;
    self.textLabel.text = cellModel.title;
    self.textLabel.textColor = [UIColor colorWithWhite:0.298 alpha:1.000];
    self.textLabel.font = [UIFont systemFontOfSize:16];
    if (cellModel.icon) {
        self.imageView.image = [UIImage imageNamed:cellModel.icon];
    }
    if (cellModel.userIcon) {
        [self.userIconBtn setImage:[UIImage imageNamed:cellModel.userIcon] forState:UIControlStateNormal];
        [self addSubview:self.userIconBtn];
    }
    if (cellModel.rightLabel) {
        self.rightLabel.text = cellModel.rightLabel;
        [self addSubview:self.rightLabel];
    }
    if ([self.cellModel isKindOfClass:[PEProfileCellArrowModel class]]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.userIconBtn setFrame:CGRectMake(CGRectGetWidth(self.frame)-100, 0, 70, 70)];
    [self.userIconBtn setCenterY:self.width * 0.5];
    
    [self.rightLabel setFrame:CGRectMake(CGRectGetWidth(self.frame)-140, 0, 200, 50)];
    [self.rightLabel setCenterY:self.height * 0.5];
    
    self.buttomLineView.frame = CGRectMake(0, CGRectGetHeight(self.frame)-0.5, SCREENWIDTH, 0.5);
}

 


@end
