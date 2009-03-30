//
//  RootViewController.m
//  DevilsDictionary
//
//  Created by Collin on 3/16/09.
//  Copyright Nimble Technique, LLC 2009. All rights reserved.
//

#import "RandomWordViewController.h"
#import "DevilsDictionaryAppDelegate.h"
#import "DefinitionViewController.h"

@implementation RandomWordViewController

@synthesize appDelegate;

- (void)viewDidLoad {
  [super viewDidLoad];
  NSLog(@"App delegate has %d words", [appDelegate.words count]);
  
  NSMutableArray *sortedWords = [[NSMutableArray arrayWithArray:appDelegate.words] retain];
  unsigned int length = [sortedWords count];
  for (int idx=0; idx < length; idx++) {
    unsigned int randIdx = random();
    randIdx = randIdx % length;
    [sortedWords exchangeObjectAtIndex:idx withObjectAtIndex:randIdx];
  }
  words = sortedWords;
  NSLog(@"Random view controller has %d words", [words count]);
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
  // Release anything that's not essential, such as cached data
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [words count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  static NSString *CellIdentifier = @"DefinitionName";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
  }
  
  NSString *name = (NSString *)[words objectAtIndex:indexPath.row];
  
  // Set up the cell...
  cell.text = name;
  
  return cell;
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
  [words release];
  [appDelegate release];
  [super dealloc];
}


@end

