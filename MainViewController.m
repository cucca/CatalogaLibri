//
//  MainViewController.m
//  CatalogaLibri
//
//  Created by Denis Cuccarini on 23/12/12.
//  Copyright (c) 2012 Denis Cuccarini. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController (){
    NSMutableArray *libriArray;
    NSMutableArray *filteredLibri;
    BOOL searching;
    BOOL letUserSelectRow;
}

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"Catalogo";
        //Right NavigationBar button
        addButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonTapped)];
        self.navigationItem.rightBarButtonItem=addButton;
        

        self.editButton=[[UIBarButtonItem alloc] initWithTitle:@"Cancella" style:UIBarButtonItemStylePlain target:self action:@selector(editButtonTapped:)];
        
        self.navigationItem.leftBarButtonItem=self.editButton;
        self.libri=[[Libro alloc]init];
        libriArray=[[Libro elencoLibri] mutableCopy];
        filteredLibri=[[NSMutableArray alloc] initWithCapacity:[libriArray count]];
        [filteredLibri addObjectsFromArray:libriArray];
        
        CGRect myview=[[UIScreen mainScreen] bounds];
        
        self.libriTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0,
                                                                            myview.size.width,
                                                                            myview.size.height -44-44)
                                                                  style:UITableViewStylePlain];
        self.libriTableView.delegate=self;
        self.libriTableView.dataSource=self;
        [self.view addSubview:self.libriTableView];
        //Gestione searchBar
        searching=NO;
        letUserSelectRow=YES;
        searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 70, 320, 44)];
        self.mySearchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
        self.mySearchDisplayController.delegate = self;
        self.mySearchDisplayController.searchResultsDataSource = self;
        self.mySearchDisplayController.searchResultsDelegate = self;

        self.libriTableView.tableHeaderView = searchBar;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

//Ricarico i dati e la UITableView quando torno alla
//view dopo la pressione del tasto Back
-(void)viewWillAppear:(BOOL)animated{
    libriArray=[[Libro elencoLibri] mutableCopy];
    [filteredLibri removeAllObjects];
    [filteredLibri addObjectsFromArray:libriArray];
    [self.libriTableView reloadData];
}

#pragma mark - Gestione UISearchBar
//Codice Apple, non modificare
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    [self filterContentForSearchText:searchString scope:
	 [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
    
}
//Codice Apple, non modificare
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption{
    
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
	 [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [filteredLibri removeAllObjects];
    [filteredLibri addObjectsFromArray: libriArray];
}

//Criterio di ricerca
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope{
    
	/*
	 Update the filtered array based on the search text and scope.
	 */
	[filteredLibri removeAllObjects]; // First clear the filtered array.
    
	/*
	 Search the main list for products whose type matches the scope (if selected) and whose name matches searchText; add items that match to the filtered array.
	 */
    Libro *libroTitolo;
    for (libroTitolo in libriArray){
        NSComparisonResult result = [libroTitolo.titolo compare:searchText options:NSCaseInsensitiveSearch range:NSMakeRange(0,[searchText length])];
		if (result == NSOrderedSame){
			[filteredLibri addObject:libroTitolo];
		}
	}
}


#pragma mark - Gestione UINavigationBar
-(void)addButtonTapped{
    addView=[[AddViewController alloc]initWithNibName:@"AddView" bundle:nil];
    [self.navigationController pushViewController:addView animated:YES];
}

-(void)editButtonTapped:(id)sender{
    if (self.libriTableView.editing){
        [self.libriTableView setEditing:NO animated:YES];
        [self.editButton setStyle:UIBarButtonItemStylePlain];
        [self.editButton setTitle:@"Cancella"];
        [self.editButton setTintColor:nil];
    }else{
        [self.libriTableView setEditing:YES animated:YES];
      //  [self.editButton setStyle:UIBarButtonItemStyleDone];
        [self.editButton setTitle:@"Done"];
        [self.editButton setTintColor:[UIColor redColor]];
    }
}


#pragma mark - Gestione UITableView
//Imposta il numero di righe della UITableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //return [libriArray count];
    return [filteredLibri count];
}

//Imposta l'altezza delle celle della UITableView
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

//Gestione delle celle: se non esistono le crea
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *reuseID=@"myIdentifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:reuseID];
    if(cell==nil){
        cell=[[UITableViewCell alloc]
               initWithStyle:UITableViewCellStyleSubtitle
               reuseIdentifier:reuseID];
    }
    Libro *l=[filteredLibri objectAtIndex:indexPath.row];
    cell.textLabel.text=l.titolo;
    cell.detailTextLabel.text=l.autore;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

//Fa il commit del delete o edit della cella della UITableView
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Libro *libroDaCancellare=[[Libro alloc]init];
        libroDaCancellare=[libriArray objectAtIndex:indexPath.row];
        [self.libri cancella:libroDaCancellare.ID];
        [filteredLibri removeAllObjects];
        [filteredLibri addObjectsFromArray:[Libro elencoLibri]];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }
}

//Gestione selezione della cella
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(letUserSelectRow){
        ViewViewController *viewView=[[ViewViewController alloc]initWithNibName:@"ViewView" bundle:nil];
        [UIView beginAnimations:@"detail" context:nil];
        [UIView setAnimationDuration:1.0];
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown
                            forView:self.navigationController.view
                                cache:NO];
        Libro *l=[filteredLibri objectAtIndex:indexPath.row];
        viewView.mioLibro=l;
//BUG quando il viewView esegue l'update, aggiorna con l'id del filteredLibri che è errato!!!
        viewView.idLibro=viewView.mioLibro.ID;
        [self.navigationController pushViewController:viewView animated:NO];
        [UIView commitAnimations];
    }
}

@end
