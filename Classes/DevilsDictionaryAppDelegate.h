//
//  DevilsDictionaryAppDelegate.h
//  DevilsDictionary
//
//  Created by Collin on 3/16/09.
//  Copyright Nimble Technique, LLC 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DevilsDictionaryAppDelegate : NSObject <UIApplicationDelegate, UITabBarDelegate> {
    
  UIWindow *window;
  IBOutlet UITabBarController *tabBarController;

  NSString *dbFilePath;
  NSArray *words;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) NSArray *words;

- (BOOL) initializeDatabase;
- (void) loadWords;
- (NSString *)definitionForWord:(NSString *)word;

@end

