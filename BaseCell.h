//
//  BaseCell.h
//  CatalogaLibri
//
//  Created by Denis Cuccarini on 04/01/13.
//  Copyright (c) 2013 Denis Cuccarini. All rights reserved.
//

// Nome della notifica di fine editing
#define CELL_ENDEDIT_NOTIFICATION_NAME @"CellEndEdit"

#import <UIKit/UIKit.h>

@interface BaseCell : UITableViewCell

@property (nonatomic, retain) NSString *dataKey;

-(void)postEndEditingNotification;
-(id)getControlValue;
-(void)setControlValue:(id)value;
@end
