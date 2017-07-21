//
//  MSUDanamicTableCell.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/7/21.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUDanamicTableCell.h"

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"


@implementation MSUDanamicTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createContentView];
    }
    return self;
}


- (void)createContentView{
    
}

@end
