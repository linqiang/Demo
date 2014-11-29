//
//  FCShoppingCell.m
//  Flower&Cake
//
//  Created by 123 on 13-8-13.

//

#import "FCShoppingCell.h"

@implementation FCShoppingCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor=[UIColor colorWithRed:.95 green:.95 blue:.95 alpha:1.0];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
