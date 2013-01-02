//
//  ViewViewController.m
//  CatalogaLibri
//
//  Created by Denis Cuccarini on 30/12/12.
//  Copyright (c) 2012 Denis Cuccarini. All rights reserved.
//

#import "ViewViewController.h"

@interface ViewViewController ()

@end

@implementation ViewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        CGRect schermo=[[UIScreen mainScreen] bounds];
        self.mioLibro=[[Libro alloc]init];
        UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 45, 50, 20)];
        titleLabel.text=@"Titolo:";
        [self.view addSubview:titleLabel];
        
        self.titoloText=[[UITextField alloc]initWithFrame:CGRectMake(100, 45, 200, 30)];
        self.titoloText.enabled=NO;
        self.titoloText.delegate=self;
        self.titoloText.text=self.mioLibro.titolo;
        [self.view addSubview:self.titoloText];
        NSLog(@"Dentro: %@",[self.mioLibro valueForKey:@"titolo"]);
        
        UILabel *autoreLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 85, 70, 20)];
        autoreLabel.text=@"Autore:";
        [self.view addSubview:autoreLabel];
        
        self.autoreText=[[UITextField alloc]initWithFrame:CGRectMake(100, 85, 200, 30)];
        self.autoreText.enabled=NO;
        //        self.autoreText.placeholder=@"autore libro...";
        self.autoreText.delegate=self;
        [self.view addSubview:self.autoreText];
        
        
        UILabel *editoreLabel=[[UILabel alloc]initWithFrame:CGRectMake(20,125, 70, 20)];
        editoreLabel.text=@"Editore:";
        [self.view addSubview:editoreLabel];
        
        self.editoreText=[[UITextField alloc]initWithFrame:CGRectMake(100,125, 200, 30)];
        self.editoreText.enabled=NO;
        //        self.editoreText.placeholder=@"editore libro...";
        self.editoreText.delegate=self;
        [self.view addSubview:self.editoreText];
        
        UILabel *annoLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 165, 70, 20)];
        annoLabel.text=@"Anno:";
        [self.view addSubview:annoLabel];
        
        self.annoText=[[UITextField alloc]initWithFrame:CGRectMake(200, 165, 100, 30)];
        self.annoText.enabled=NO;
        self.annoText.delegate=self;
        self.annoText.tag=3;
        self.annoText.keyboardType=UIKeyboardTypeNumberPad;
        [self.view addSubview:self.annoText];
        
        

        
//        [self initializeControls];
        

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   // self.titoloText.text=self.mioLibro.titolo;
   // self.titoloText.text=_mioLibro.titolo;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    self.titoloText.text=self.mioLibro.titolo;
    self.autoreText.text=self.mioLibro.autore;
    self.editoreText.text=self.mioLibro.editore;
    self.annoText.text=[NSString stringWithFormat:@"%d",self.mioLibro.annoPubblicazione];
    self.editButton=[[UIBarButtonItem alloc] initWithTitle:@"Modifica" style:UIBarButtonItemStylePlain target:self action:@selector(editButtonTapped:)];
    
    self.navigationItem.rightBarButtonItem=self.editButton;
}

-(void)viewWillDisappear:(BOOL)animated{
    self.mioLibro.titolo=self.titoloText.text;
    self.mioLibro.editore=self.editoreText.text;
    self.mioLibro.autore=self.autoreText.text;
    self.mioLibro.annoPubblicazione=[self.annoText.text intValue];
    
    [self.mioLibro aggiorna:self.mioLibro.ID libroAggiornato:self.mioLibro];
    
    
//    [self.mioLibro aggiorna:self.idLibro libroAggiornato:self.mioLibro];
}

#pragma mark - UIButtons
-(void)editButtonTapped:(id)sender{
    if (self.editButton.title==@"Modifica"){
        [self.editButton setTitle:@"Done"];
        [self.editButton setTintColor:[UIColor redColor]];
        self.titoloText.enabled=YES;
        [self.titoloText setBorderStyle:UITextBorderStyleRoundedRect];
        self.editoreText.enabled=YES;
        [self.editoreText setBorderStyle:UITextBorderStyleRoundedRect];
        self.autoreText.enabled=YES;
        [self.autoreText setBorderStyle:UITextBorderStyleRoundedRect];
        self.annoText.enabled=YES;
        [self.annoText setBorderStyle:UITextBorderStyleRoundedRect];
    }else{
        [self.editButton setTitle:@"Modifica"];
        [self.editButton setTintColor:nil];
        self.titoloText.enabled=NO;
        [self.titoloText setBorderStyle:UITextBorderStyleNone];
        self.editoreText.enabled=NO;
        [self.editoreText setBorderStyle:UITextBorderStyleNone];
        self.autoreText.enabled=NO;
        [self.autoreText setBorderStyle:UITextBorderStyleNone];
        self.annoText.enabled=NO;
        [self.annoText setBorderStyle:UITextBorderStyleNone];
    }
}

#pragma marks - TextFields Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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

@end
