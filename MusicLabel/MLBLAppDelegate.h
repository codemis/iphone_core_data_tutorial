//
//  MLBLAppDelegate.h
//  MusicLabel
//
//  Created by Johnathan Pulos on 4/2/13.
//  Copyright (c) 2013 Johnathan Pulos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLBLAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end