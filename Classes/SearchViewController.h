//
//  SearchViewController.h
//  DevilsDictionary
//
//  Created by Collin on 3/19/09.
//  Copyright 2009 Nimble Technique, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DevilsDictionaryAppDelegate.h"

@interface SearchViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate> {

  IBOutlet DevilsDictionaryAppDelegate *appDelegate;
  IBOutlet UISearchBar *searchBar;
  IBOutlet UITableView *tableView;
  
  NSArray *words;

}

@property (nonatomic, retain) DevilsDictionaryAppDelegate *appDelegate;
@property (nonatomic, retain) UISearchBar *searchBar;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSArray *words;

- (void) search;
- (void) reset;

@end
