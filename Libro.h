//
//  Libro.h
//  CatalogaLibri
//
//  Created by Denis Cuccarini on 23/12/12.
//  Copyright (c) 2012 Denis Cuccarini. All rights reserved.
//

#define kFileName   @"libri.plist"

#import <objc/runtime.h>
#import <Foundation/Foundation.h>

@interface Libro : NSObject <NSCoding>
@property(nonatomic,assign) NSInteger ID;
@property (nonatomic,strong) NSString *titolo;
@property(nonatomic,strong) NSString *autore;
@property(nonatomic,strong) NSString *editore;
@property(nonatomic,assign) NSInteger annoPubblicazione;

-(void)aggiungi: (Libro *)libroDaAggiungere;
-(void)cancella:(NSInteger)idLibro;
-(void)aggiorna:(NSInteger)idLibro libroAggiornato:(Libro *)libro;
-(void)scriviTuttiLibri:(NSArray *)libri;
- (NSArray *)getAllPropertyNames;
+(NSArray *)elencoLibri;
+(NSString *)dataFilePath;
@end
