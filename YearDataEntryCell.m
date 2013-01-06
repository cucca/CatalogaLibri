//
//  YearDataEntryCell.m
//  CatalogaLibri
//
//  Created by Denis Cuccarini on 04/01/13.
//  Copyright (c) 2013 Denis Cuccarini. All rights reserved.
//

#import "YearDataEntryCell.h"

@interface YearDataEntryCell() {
    NSMutableArray *pickerYears;
}

@end

@implementation YearDataEntryCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Initialization code
        // Configuro l'yearPicker
        pickerYears=[[NSMutableArray alloc]init];
        for (int i=1900;i<2100;i++){
            [pickerYears addObject:[NSString stringWithFormat:@"%d",i]];
        }
        
        self.pickerView=[[UIPickerView alloc]initWithFrame:CGRectZero];
        self.pickerView.showsSelectionIndicator = YES;
        self.pickerView.delegate=self;

        [self.contentView addSubview:self.pickerView];
        
        NSDateFormatter *dateF=[[NSDateFormatter alloc]init];
        [dateF setDateFormat:@"yyyy"];
        NSString *anno=[dateF stringFromDate:[NSDate date]];
        [self.pickerView selectRow:[pickerYears indexOfObject:anno] inComponent:0 animated:NO];
    }
    return self;

}
-(void)layoutSubviews{
	[super layoutSubviews];
    
	CGRect labelRect = CGRectMake(self.textLabel.frame.origin.x,
                                  self.textLabel.frame.origin.y,
                                  self.contentView.frame.size.width * .35,
                                  self.textLabel.frame.size.height);
	[self.textLabel setFrame:labelRect];
    
	// Rect area del textbox
    /*
	CGRect rect = CGRectMake(self.textLabel.frame.origin.x + self.textLabel.frame.size.width  + PICKER_CONTROL_PADDING,
							 12.0,
							 self.contentView.frame.size.width-(self.textLabel.frame.size.width + PICKER_CONTROL_PADDING + self.textLabel.frame.origin.x)-RIGHT_PADDING,
							 25.0);
     */
	CGRect rect = CGRectMake(self.textLabel.frame.origin.x + self.textLabel.frame.size.width  + PICKER_CONTROL_PADDING,
							 12.0,
							 130,
							 216.0);
	[self.pickerView setFrame:rect];
}




#pragma mark - Ovveride Metodi
-(id)getControlValue{
//    return self.pickerView.s
}

-(void)setControlValue:(id)value{
//    self.textField.text=value;
    [self.pickerView selectRow:[pickerYears indexOfObject:value] inComponent:0 animated:NO];
}


#pragma mark - UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    // Handle the selection
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [pickerYears count];
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {

    return [NSString stringWithFormat:@"%@",[pickerYears objectAtIndex:row]];
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = 300;
    
    return sectionWidth;
}

@end
