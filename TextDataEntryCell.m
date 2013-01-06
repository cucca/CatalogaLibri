//
//  TextDataEntryCell.m
//  CatalogaLibri
//
//  Created by Denis Cuccarini on 04/01/13.
//  Copyright (c) 2013 Denis Cuccarini. All rights reserved.
//

#import "TextDataEntryCell.h"

@implementation TextDataEntryCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Initialization code
        // Configuro il textfield secondo la necessità
		self.textField = [[UITextField alloc] initWithFrame:CGRectZero];
		self.textField.clearsOnBeginEditing = NO;
		self.textField.textAlignment = UITextAlignmentLeft;
		self.textField.returnKeyType = UIReturnKeyDone;
		self.textField.font = [UIFont systemFontOfSize:14];
		self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
		self.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        //self.textField.backgroundColor=[UIColor redColor];
        self.textField.placeholder=@"Scrivi qui...";
        self.textField.delegate=self;
		[self.contentView addSubview:self.textField];
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
	CGRect rect = CGRectMake(self.textLabel.frame.origin.x + self.textLabel.frame.size.width  + LABEL_CONTROL_PADDING,
							 12.0,
							 self.contentView.frame.size.width-(self.textLabel.frame.size.width + LABEL_CONTROL_PADDING + self.textLabel.frame.origin.x)-RIGHT_PADDING,
							 25.0);
    
	[self.textField setFrame:rect];
}

#pragma mark - Ovveride Metodi
-(id)getControlValue{
    return self.textField.text;
}

-(void)setControlValue:(id)value{
    self.textField.text=value;
}

#pragma mark UITextFieldDelegate

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    self.textField.placeholder=@"";
}

- (void)textFieldDidEndEditing:(UITextField *)txtField
{
	[self postEndEditingNotification];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}


@end
