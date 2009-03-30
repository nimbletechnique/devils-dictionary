//
//  SearchViewController.m
//  DevilsDictionary
//
//  Created by Collin on 3/19/09.
//  Copyright 2009 Nimble Technique, LLC. All rights reserved.
//

#import "SearchViewController.h"
#import "DefinitionViewController.h"

@implementation SearchViewController

@synthesize appDelegate;
@synthesize searchBar;
@synthesize tableView;
@synthesize words;

- (void)dealloc {
  [appDelegate release];
  [searchBar release];
  [tableView release];
  [words release];
  [super dealloc];
}

- (void) reset {
  NSLog(@"Resetting");
  self.words = [appDelegate words];
  [tableView reloadData];
}

- (void) search {
  NSLog(@"Searching with text: %@", searchBar.text);
  NSMutableArray *newWords = [[[NSMutableArray alloc] init] autorelease];
  NSEnumerator *enumerator = [[appDelegate words] objectEnumerator];
  NSString *word;
  while ((word = (NSString *)[enumerator nextObject]) != nil) {
    NSRange range = [word rangeOfString:searchBar.text options:NSCaseInsensitiveSearch];
    if (range.location != NSNotFound) {
      [newWords addObject:word];
    }
  }

  NSLog(@"Found %d searched words", [newWords count]);
  self.words = newWords;
  [tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSString *word = [words objectAtIndex:indexPath.row];
  NSString *definition = [appDelegate definitionForWord:word];
  DefinitionViewController *controller = [[DefinitionViewController alloc] initWithNibName:@"DefinitionViewController" bundle:nil];
  controller.word = word;
  controller.definition = definition;
  [self.navigationController pushViewController:controller animated:YES];
  [controller release];
  
}

- (void)viewDidLoad {
  self.words = [appDelegate words];
  NSLog(@"Search view loaded with %d words", [words count]);
  [searchBar becomeFirstResponder];
  [super viewDidLoad];
}

// search methods

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)aSearchBar {
  NSLog(@"Search bar should end editing");
  return YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)aSearchBar {
  NSLog(@"Search bar text did end editing");

}

- (void)searchBar:(UISearchBar *)aSearchBar textDidChange:(NSString *)searchText {
  NSLog(@"Search bar text changed");
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)aSearchBar {
  NSLog(@"Search bar cancel clicked");
  [aSearchBar resignFirstResponder];
  [self reset];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)aSearchBar {
  [aSearchBar resignFirstResponder];
  NSLog(@"Search button clicked");
  [self search];
}



// table view methods

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  static NSString *CellIdentifier = @"SearchName";
  
  UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
  }
  
  // Set up the cell...
  cell.text = [words objectAtIndex:indexPath.row];
  // cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  
  return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [words count];
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


@end
