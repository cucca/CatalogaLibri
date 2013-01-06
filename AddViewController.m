//
//  AddViewController.m
//  CatalogaLibri
//
//  Created by Denis Cuccarini on 29/12/12.
//  Copyright (c) 2012 Denis Cuccarini. All rights reserved.
//

#import "AddViewController.h"
#import "Libro.h"
#import "BaseCell.h"

@interface AddViewController (){
    NSMutableString *prevPlaceHolder;
    Libro *newLibro;
    NSArray *libroArray;
    NSArray *propertiesNames;
}

@end

@implementation AddViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        CGRect schermo=[[UIScreen mainScreen] bounds];
        newLibro=[[Libro alloc]init];
        libroArray=[[NSArray alloc]initWithObjects:@"Titolo",@"Autore",@"Editore",@"Anno Pubblicazione", nil];
        propertiesNames=[[NSArray alloc]initWithArray:[newLibro getAllPropertyNames]];

        //TableView
        self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, schermo.size.width, schermo.size.height) style:UITableViewStyleGrouped];
        self.tableView.delegate=self;
        self.tableView.dataSource=self;
        [self.view addSubview:self.tableView];
        //Gesture Recognizer
        self.tapRecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                   action:@selector(tapRecognized:)];
        [self.view addGestureRecognizer:self.tapRecognizer];

        //NavigationBar Buttons
        UIButton *aggiungiButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        aggiungiButton.frame=CGRectMake((schermo.size.width-100)/2, 220, 100, 50);
        [aggiungiButton addTarget:self
                           action:@selector(addButtonTapped:)
                 forControlEvents:UIControlEventTouchUpInside];
        [aggiungiButton setTitle:@"Aggiungi" forState:UIControlStateNormal];
    //    [self.view addSubview:aggiungiButton];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Mi registro al notification center per ricevere il messaggio di fine edit UITextField
    [[NSNotificationCenter defaultCenter]
	 addObserver:self
	 selector:@selector(cellControlDidEndEditing:)
	 name:CELL_ENDEDIT_NOTIFICATION_NAME
	 object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Gesture Recognizer
-(void)tapRecognized:(UITapGestureRecognizer *)sender{
   // [sender becomeFirstResponder];
    [self.view endEditing:YES];
}

#pragma mark - NotificationCenter

-(void)cellControlDidEndEditing:(NSNotification *)notification
{
    NSIndexPath *cellIndex = (NSIndexPath *)[notification object];
    NSLog(@"CellIndex=%d",cellIndex.row);
	BaseCell *cell = (BaseCell *)[self.tableView cellForRowAtIndexPath:cellIndex];
	if(cell != nil)
	{
        if(cell.dataKey!=@"annoPubblicazione"){
            [newLibro setValue:[cell getControlValue] forKey:cell.dataKey];
        }else{
            NSNumberFormatter *f=[[NSNumberFormatter alloc]init];
            [f setNumberStyle:NSNumberFormatterDecimalStyle];
            [newLibro setValue:[f numberFromString:[cell getControlValue]] forKey:cell.dataKey];
        }
		NSLog(@"L'utente ha digitato %@ per la datakey %@",  [cell getControlValue], cell.dataKey);
	}
}


#pragma mark - UITableViewDelegate

#pragma mark - UITableViewDataSourceDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    
    NSString *cellType;
    
    if ([[propertiesNames objectAtIndex:indexPath.row+1] isEqual:@"annoPubblicazione"] ){
        cellType = @"YearDataEntryCell";
    }else{
        cellType = @"TextDataEntryCell";
    }
    NSLog(@"CellType=%@",cellType);
	BaseCell *cell = (BaseCell *)[tableView dequeueReusableCellWithIdentifier:cellType];
	if (cell == nil) {
        
        cell = [[NSClassFromString(cellType) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.dataKey=[propertiesNames objectAtIndex:indexPath.row+1];
	cell.textLabel.text = [libroArray objectAtIndex:indexPath.row];
    NSLog(@"Altezza: %f",cell.frame.size.height);
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [libroArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==3){
        return 250;
    }else{
        return 44;
    }
 
}

#pragma mark - UIButton
-(void) addButtonTapped:(id)sender{
    [newLibro aggiungi:newLibro];
    
    UIAlertView *av=[[UIAlertView alloc]initWithTitle:@"Fatto" message:@"Libro aggiunto con successo!"
                                             delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [av show];
}

#pragma mark - UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    prevPlaceHolder=[NSMutableString stringWithFormat:@"%@", textField.placeholder];
    textField.placeholder=@"";
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if ([textField.text isEqualToString:@""]){
        textField.placeholder=prevPlaceHolder;
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
                            replacementString:(NSString *)string{

    NSArray *numbers=[[NSArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0", nil];

    if(textField.tag==3 && [string length]>0){

        NSUInteger newLength = [textField.text length] + [string length] - range.length;

        if (([numbers containsObject:string] == NO) || (newLength>4)){
            return NO;
        }else{
            return YES;
        }
    }else{
        return YES;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
@end
