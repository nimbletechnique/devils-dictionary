//
//  RandomWordViewController.h
//  DevilsDictionary
//
//  Created by Collin on 3/18/09.
//  Copyright 2009 Nimble Technique, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "DevilsDictionaryAppDelegate.h"


@interface RandomWordViewController : UITableViewController <UITableViewDelegate> {
  
  IBOutlet DevilsDictionaryAppDelegate *appDelegate;
  NSArray *words;

}

@property (nonatomic, retain) DevilsDictionaryAppDelegate *appDelegate;


@end
