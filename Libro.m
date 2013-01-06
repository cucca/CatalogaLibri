//
//  Libro.m
//  CatalogaLibri
//
//  Created by Denis Cuccarini on 23/12/12.
//  Copyright (c) 2012 Denis Cuccarini. All rights reserved.
//

#import "Libro.h"
@interface Libro (){
    NSArray *dataArray;
}
@end


@implementation Libro

+(NSString *)dataFilePath{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(
                                                       NSDocumentDirectory,
                                                       NSUserDomainMask,
                                                       YES);
    NSString *documentsPath=[paths objectAtIndex:0];
    NSLog(@"Path: %@",[documentsPath stringByAppendingPathComponent:kFileName]);
    return [documentsPath stringByAppendingPathComponent:kFileName];
}

+(NSArray *)elencoLibri{
    NSString *filePath=[Libro dataFilePath];
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        NSData *myData=[[NSData alloc] initWithContentsOfFile:filePath];
        
        NSMutableArray *myArray=[NSKeyedUnarchiver unarchiveObjectWithData:myData];

        return myArray;
    }else{
        return nil;
    }
}

-(void)aggiungi:(Libro *)libroDaAggiungere{
    NSArray *storedData=[NSArray array];
    storedData=[Libro elencoLibri];
    NSMutableArray *dataArray2=[NSMutableArray array];
    for(int i=0;i<[storedData count];i++){
        [dataArray2 addObject:[storedData objectAtIndex:i]];
    }
    //Recupero l'ultimo oggetto inserito nell'array e ne prendo l'ID
    Libro *l=[[Libro alloc]init];
    NSInteger nextID;
    if ([dataArray2 count]>0){
        l=[dataArray2 objectAtIndex:[dataArray2 count]-1];
        nextID=l.ID+1;
    }else{
        nextID=0;
    }
    

    //Assegno l'ID all'item da aggiungere incrementato di 1
    libroDaAggiungere.ID=nextID;
    [dataArray2 addObject:libroDaAggiungere];

    NSData *myData=[NSKeyedArchiver archivedDataWithRootObject:dataArray2];
    NSLog(@"percorso: %@",[Libro dataFilePath]);
    if ([myData writeToFile:[Libro dataFilePath] atomically:YES]){
        NSLog(@"File scritto correttamente!");
    }else{
        NSLog(@" ### impossibile scrivere il file ###!!!");
    }
}


-(void)aggiorna:(NSInteger)idLibro libroAggiornato:(Libro *)libro{
    NSMutableArray *dataArray2=[NSMutableArray array];
    NSArray *storeData=[[NSArray alloc] initWithArray:[Libro elencoLibri]];

    for (int i=0;i<[storeData count];i++){
        [dataArray2 addObject:[storeData objectAtIndex:i]];
    }

    [dataArray2 replaceObjectAtIndex:idLibro withObject:libro];
    [self scriviTuttiLibri:dataArray2];
}

-(void)scriviTuttiLibri:(NSArray *)libri{
    NSData *myData=[NSKeyedArchiver archivedDataWithRootObject:libri];
    NSLog(@"percorso: %@",[Libro dataFilePath]);
    if ([myData writeToFile:[Libro dataFilePath] atomically:YES]){
        NSLog(@"File scritto correttamente!");
    }else{
        NSLog(@" ### impossibile scrivere il file ###!!!");
    }
}

-(void)cancella:(NSInteger)idLibro{
    NSArray *storeData=[[NSArray alloc] initWithArray:[Libro elencoLibri]];
    NSMutableArray *dataArray2=[[NSMutableArray alloc]init];
    for (int i=0;i<[storeData count];i++){
        [dataArray2 addObject:[storeData objectAtIndex:i]];
    }
    Libro *l;
    for(int i=0;i<[dataArray2 count];i++){
        l=[dataArray2 objectAtIndex:i];
        if (l.ID==idLibro){
                [dataArray2 removeObjectAtIndex:i];
        }
    }
//    [dataArray2 removeObjectAtIndex:idLibro];
    [self scriviTuttiLibri:dataArray2];
}

#pragma mark - NSCoding Methods

- (id) initWithCoder:(NSCoder *)aDecoder{
    
    self=[super init];
    if (self){
        self.ID=[aDecoder decodeIntegerForKey:@"kID"];
        self.titolo=[aDecoder decodeObjectForKey:@"kTitoloKey"];
        self.autore=[aDecoder decodeObjectForKey:@"kAutoreKey"];
        self.editore=[aDecoder decodeObjectForKey:@"kEditoreKey"];
        self.annoPubblicazione=[aDecoder decodeIntegerForKey:@"kAnnoPubblicazioneKey"];
    }
    
    return self;
    
}

- (void) encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeInteger:self.ID forKey:@"kID"];
    [aCoder encodeObject:self.titolo forKey:@"kTitoloKey"];
    [aCoder encodeObject:self.autore forKey:@"kAutoreKey"];
    [aCoder encodeObject:self.editore forKey:@"kEditoreKey"];
    [aCoder encodeInteger:self.annoPubblicazione forKey:@"kAnnoPubblicazioneKey"];
}

- (NSArray *)getAllPropertyNames
{
    unsigned count;

    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    NSMutableArray *rv = [NSMutableArray array];
    
    unsigned i;
    for (i = 0; i < count; i++)
    {
        objc_property_t property = properties[i];
        NSString *name = [NSString stringWithUTF8String:property_getName(property)];
        [rv addObject:name];
    }
    
    free(properties);
    
    return rv;
}


@end
