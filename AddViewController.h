//
//  AddViewController.h
//  CatalogaLibri
//
//  Created by Denis Cuccarini on 29/12/12.
//  Copyright (c) 2012 Denis Cuccarini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddViewController : UIViewController <UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,retain) IBOutlet UITextField *titoloText;
@property (nonatomic,retain) IBOutlet UITextField *autoreText;
@property (nonatomic,retain) IBOutlet UITextField *editoreText;
@property (nonatomic,retain) IBOutlet UITextField *annoText;
@property (nonatomic,retain) UITapGestureRecognizer *tapRecognizer;
@property (nonatomic,retain) IBOutlet UITableView *tableView;

@end
