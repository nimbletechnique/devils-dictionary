//
//  RootViewController.m
//  DevilsDictionary
//
//  Created by Collin on 3/16/09.
//  Copyright Nimble Technique, LLC 2009. All rights reserved.
//

#import "AlphabeticalWordViewController.h"
#import "DevilsDictionaryAppDelegate.h"
#import "DefinitionViewController.h"

@implementation AlphabeticalWordViewController

@synthesize appDelegate;
@synthesize letters;
@synthesize letterLookup;


- (void)viewDidLoad {
  [super viewDidLoad];
  words = [appDelegate.words retain];
  [self setupLetters];
  [self setupLetterLookup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

#pragma mark Table view methods

- (void) setupLetterLookup {
  NSMutableDictionary *lu = [[[NSMutableDictionary alloc] initWithCapacity:26] autorelease];
  for (int idx=0; idx < [words count]; idx++) {
    NSString *word = (NSString *)[words objectAtIndex:idx];
    NSString *letter = [word substringWithRange:(NSRange){0,1}];
    NSMutableArray *letterArray = [lu objectForKey:letter];
    if (letterArray == nil) {
      letterArray = [[[NSMutableArray alloc] init] autorelease];
      [lu setObject:letterArray forKey:letter];
    }
    [letterArray addObject:word];
  }
  self.letterLookup = lu;
}

- (void) setupLetters {
  NSString *chars = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  NSMutableArray *array = [[[NSMutableArray alloc] init] autorelease];
  for (int idx=0; idx < [chars length]; idx++) {
    unichar character = [chars characterAtIndex:idx];
    NSString *letter = [NSString stringWithCharacters:&character length:1];
    [array addObject:letter];
  }
  self.letters = array;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
  return index;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
  return letters;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return [letters count];
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  NSString *key = [letters objectAtIndex:section];
  NSArray *luLetters = (NSArray *)[letterLookup objectForKey:key];
  int numberOfRows = [luLetters count];
  NSLog(@"There are %d rows in the section for %@", numberOfRows, key);
  return numberOfRows;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  static NSString *CellIdentifier = @"DefinitionName";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
      cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
  }

  // Set up the cell...
  cell.text = [self wordForIndexPath:indexPath];
  // cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

  return cell;
}

- (NSString *) wordForIndexPath:(NSIndexPath *)indexPath {
  return [(NSArray *)[letterLookup objectForKey:[letters objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSString *word = [self wordForIndexPath:indexPath];
  NSString *definition = [appDelegate definitionForWord:word];
  DefinitionViewController *controller = [[DefinitionViewController alloc] initWithNibName:@"DefinitionViewController" bundle:nil];
  controller.word = word;
  controller.definition = definition;
  [self.navigationController pushViewController:controller animated:YES];
  [controller release];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  return [letters objectAtIndex:section];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (void)dealloc {
  [letters release];
  [words release];
  [appDelegate release];
  [super dealloc];
}


@end

