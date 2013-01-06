//
//  TextDataEntryCell.h
//  CatalogaLibri
//
//  Created by Denis Cuccarini on 04/01/13.
//  Copyright (c) 2013 Denis Cuccarini. All rights reserved.
//

// Padding tra i controlli nella cella
#define LABEL_CONTROL_PADDING 5
// Padding del controllo rispetto al
#define RIGHT_PADDING 5


#import "BaseCell.h"


@interface TextDataEntryCell : BaseCell <UITextFieldDelegate>

@property (nonatomic,retain) UITextField *textField;

@end
