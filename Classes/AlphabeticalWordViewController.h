//
//  RootViewController.h
//  DevilsDictionary
//
//  Created by Collin on 3/16/09.
//  Copyright Nimble Technique, LLC 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "DevilsDictionaryAppDelegate.h"

@interface AlphabeticalWordViewController : UITableViewController <UITableViewDelegate> {
  
  IBOutlet DevilsDictionaryAppDelegate *appDelegate;
  NSArray *words;
  NSArray *letters;
  NSDictionary *letterLookup;
}

@property (nonatomic, retain) DevilsDictionaryAppDelegate *appDelegate;
@property (nonatomic, retain) NSArray *letters;
@property (nonatomic, retain) NSDictionary *letterLookup;

- (void) setupLetters;
- (void) setupLetterLookup;
- (NSString *) wordForIndexPath:(NSIndexPath *)indexPath;

@end
