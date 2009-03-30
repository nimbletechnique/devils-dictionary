//
//  DevilsDictionaryAppDelegate.m
//  DevilsDictionary
//
//  Created by Collin on 3/16/09.
//  Copyright Nimble Technique, LLC 2009. All rights reserved.
//

#import "DevilsDictionaryAppDelegate.h" 
#import "AlphabeticalWordViewController.h"
#import <sqlite3.h>

@implementation DevilsDictionaryAppDelegate

@synthesize window;
@synthesize tabBarController;
@synthesize words;

NSString *DATABASE_FILE_NAME=@"words.db";
NSString *DATABASE_RESOURCE_PATH=@"words";
NSString *DATABASE_RESOURCE_TYPE=@"db";

- (BOOL) initializeDatabase {
  NSLog(@"Initializing database");
  NSString *resourceDbPath = [[NSBundle mainBundle] pathForResource:DATABASE_RESOURCE_PATH ofType:DATABASE_RESOURCE_TYPE];
  dbFilePath = [resourceDbPath retain];
  return YES;
}

- (NSString *)definitionForWord:(NSString *)word {
  sqlite3 *db;
  int dbrc;
  dbrc = sqlite3_open([dbFilePath UTF8String], &db);
  if (dbrc) {
    NSLog(@"Could not open database: %d", dbrc);
    return nil;
  }
  NSLog(@"Database opened successfully");
  
  sqlite3_stmt *dbps;
  NSString *query = [[NSString alloc] initWithFormat:@"select definition from words where name = '%@'", word];
  dbrc = sqlite3_prepare_v2(db, [query UTF8String], -1, &dbps, NULL);
  NSString *definition = nil;
  if ((dbrc = sqlite3_step(dbps)) == SQLITE_ROW) {
    definition = [[[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(dbps, 0)] autorelease];
  }
  
  sqlite3_finalize(dbps);
  sqlite3_close(db);
  [query release];
  return definition;
}

- (void) loadWords {
  NSLog(@"Loading words from %@", dbFilePath);
  NSMutableArray *loadedWords = [[NSMutableArray alloc] initWithCapacity:1000];
  sqlite3 *db;
  int dbrc;
  dbrc = sqlite3_open([dbFilePath UTF8String], &db);
  if (dbrc) {
    NSLog(@"Could not open database: %d", dbrc);
    return;
  }
  NSLog(@"Database opened successfully");
  
  sqlite3_stmt *dbps;
  NSString *query = [[NSString alloc] initWithFormat:@"select name from words order by name"];
  dbrc = sqlite3_prepare_v2(db, [query UTF8String], -1, &dbps, NULL);
  while ((dbrc = sqlite3_step(dbps)) == SQLITE_ROW) {
    NSString *name = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(dbps, 0)];
    [loadedWords addObject:name];
    [name release];
  }
  
  sqlite3_finalize(dbps);
  sqlite3_close(db);
  [query release];
  words = loadedWords;
  
  NSLog(@"Loaded %d words", [words count]);
}

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	[self initializeDatabase];
  [self loadWords];
  
	// Configure and show the window
	[window addSubview:[tabBarController view]];
	[window makeKeyAndVisible];
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}

- (void)dealloc {
  [dbFilePath release];
	[tabBarController release];
	[window release];
	[super dealloc];
}


@end
