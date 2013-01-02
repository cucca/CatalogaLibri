//
//  ViewViewController.h
//  CatalogaLibri
//
//  Created by Denis Cuccarini on 30/12/12.
//  Copyright (c) 2012 Denis Cuccarini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Libro.h"

@interface ViewViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic,retain) Libro *mioLibro;
@property (nonatomic,retain) IBOutlet UITextField *titoloText;
@property (nonatomic,retain) IBOutlet UITextField *autoreText;
@property (nonatomic,retain) IBOutlet UITextField *editoreText;
@property (nonatomic,retain) IBOutlet UITextField *annoText;
@property (nonatomic,retain) IBOutlet UIBarButtonItem *editButton;
@property (nonatomic) NSInteger idLibro;

@end
