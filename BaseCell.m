//
//  BaseCell.m
//  CatalogaLibri
//
//  Created by Denis Cuccarini on 04/01/13.
//  Copyright (c) 2013 Denis Cuccarini. All rights reserved.
//

#import "BaseCell.h"

@implementation BaseCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //riutilizzo la standard label cambiando il font
		self.textLabel.font  = [UIFont boldSystemFontOfSize:14];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)postEndEditingNotification
{
	[[NSNotificationCenter defaultCenter] postNotificationName:CELL_ENDEDIT_NOTIFICATION_NAME
                                                        object:[(UITableView *)self.superview indexPathForCell: self]];
}
-(id)getControlValue{
    return nil;
}

-(void)setControlValue:(id)value{
    
}

@end
