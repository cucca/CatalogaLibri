//
//  AddViewController.m
//  CatalogaLibri
//
//  Created by Denis Cuccarini on 29/12/12.
//  Copyright (c) 2012 Denis Cuccarini. All rights reserved.
//

#import "AddViewController.h"
#import "Libro.h"

@interface AddViewController (){
    NSMutableString *prevPlaceHolder;
}

@end

@implementation AddViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        CGRect schermo=[[UIScreen mainScreen] bounds];
        self.tapRecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                       action:@selector(tapRecognized:)];
        [self.view addGestureRecognizer:self.tapRecognizer];
        
        UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 45, 50, 20)];
        titleLabel.text=@"Titolo:";
        [self.view addSubview:titleLabel];
        
        self.titoloText=[[UITextField alloc]initWithFrame:CGRectMake(100, 45, 200, 30)];
        self.titoloText.borderStyle=UITextBorderStyleRoundedRect;
//        self.titoloText.placeholder=@"titolo libro...";
        self.titoloText.delegate=self;
        [self.view addSubview:self.titoloText];
        
        
        UILabel *autoreLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 85, 70, 20)];
        autoreLabel.text=@"Autore:";
        [self.view addSubview:autoreLabel];
        
        self.autoreText=[[UITextField alloc]initWithFrame:CGRectMake(100, 85, 200, 30)];
        self.autoreText.borderStyle=UITextBorderStyleRoundedRect;
//        self.autoreText.placeholder=@"autore libro...";
        self.autoreText.delegate=self;
        [self.view addSubview:self.autoreText];
        
        
        UILabel *editoreLabel=[[UILabel alloc]initWithFrame:CGRectMake(20,125, 70, 20)];
        editoreLabel.text=@"Editore:";
        [self.view addSubview:editoreLabel];
        
        self.editoreText=[[UITextField alloc]initWithFrame:CGRectMake(100,125, 200, 30)];
        self.editoreText.borderStyle=UITextBorderStyleRoundedRect;
//        self.editoreText.placeholder=@"editore libro...";
        self.editoreText.delegate=self;
        [self.view addSubview:self.editoreText];
        
        UILabel *annoLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 165, 70, 20)];
        annoLabel.text=@"Anno:";
        [self.view addSubview:annoLabel];
        
        self.annoText=[[UITextField alloc]initWithFrame:CGRectMake(200, 165, 100, 30)];
        self.annoText.borderStyle=UITextBorderStyleRoundedRect;
//        self.annoText.placeholder=@"anno...";
        self.annoText.delegate=self;
        self.annoText.tag=3;
        self.annoText.keyboardType=UIKeyboardTypeNumberPad;
        [self.view addSubview:self.annoText];
        
        
        UIButton *aggiungiButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        aggiungiButton.frame=CGRectMake((schermo.size.width-100)/2, 220, 100, 50);
        [aggiungiButton addTarget:self
                           action:@selector(addButtonTapped:)
                 forControlEvents:UIControlEventTouchUpInside];
        [aggiungiButton setTitle:@"Aggiungi" forState:UIControlStateNormal];
        [self.view addSubview:aggiungiButton];
        [self initializeControls];
    }
    return self;
}

-(void)initializeControls{
    self.titoloText.text=@"";
    self.autoreText.text=@"";
    self.editoreText.text=@"";
    self.annoText.text=@"";
    self.titoloText.placeholder=@"titolo libro...";
    self.autoreText.placeholder=@"autore libro...";
    self.editoreText.placeholder=@"editore libro...";
    self.annoText.placeholder=@"anno...";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

#pragma mark - UIButton
-(void) addButtonTapped:(id)sender{
    
    Libro *myLibro=[[Libro alloc]init];
    myLibro.titolo=self.titoloText.text;
    myLibro.autore=self.autoreText.text;
    myLibro.editore=self.editoreText.text;
    myLibro.annoPubblicazione=[self.annoText.text intValue];
    [myLibro aggiungi:myLibro];
    UIAlertView *av=[[UIAlertView alloc]initWithTitle:@"Fatto" message:@"Libro aggiunto con successo!"
                                             delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [av show];
    [self initializeControls];
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
