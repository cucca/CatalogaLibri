//
//  YearDataEntryCell.h
//  CatalogaLibri
//
//  Created by Denis Cuccarini on 04/01/13.
//  Copyright (c) 2013 Denis Cuccarini. All rights reserved.
//
// Padding tra i controlli nella cella
#define PICKER_CONTROL_PADDING 5
// Padding del controllo rispetto al
#define RIGHT_PADDING 5


#import "BaseCell.h"

@interface YearDataEntryCell : BaseCell <UIPickerViewDelegate>

@property (nonatomic,retain) IBOutlet UIPickerView *pickerView;

@end
