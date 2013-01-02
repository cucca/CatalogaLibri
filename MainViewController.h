//
//  MainViewController.h
//  CatalogaLibri
//
//  Created by Denis Cuccarini on 23/12/12.
//  Copyright (c) 2012 Denis Cuccarini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Libro.h"
#import "AddViewController.h"
#import "ViewViewController.h"

@interface MainViewController : UIViewController <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate>
{
//    Libro *libri;
    AddViewController *addView;
    UISearchBar *searchBar;
    UIBarButtonItem *addButton;
}

@property (nonatomic,retain) Libro *libri;
@property (nonatomic, retain) IBOutlet UITableView *libriTableView;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *editButton;
@property (nonatomic, strong) UISearchDisplayController * mySearchDisplayController; //Indispensabile per creare il UISearchDisplayController
@end
