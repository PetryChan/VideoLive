//
//  PEProfileCellGroupModel.h
//  VideoLive
//
//  Created by petry(陈荣) on 2017/4/12.
//  Copyright © 2017年 petry(陈荣). All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PEProfileCellGroupModel : NSObject

/** <#description#>  */
@property (nonatomic,strong) NSArray *cells;
/** <#description#>  */
@property (nonatomic,copy) NSString *headerTitle;
/** <#description#>  */
@property (nonatomic,copy) NSString *footerTitle;

- (instancetype)initWithCells:(NSArray *)cells;

@end
