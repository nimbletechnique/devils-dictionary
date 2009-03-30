//
//  DefinitionViewController.m
//  DevilsDictionary
//
//  Created by Collin on 3/18/09.
//  Copyright 2009 Nimble Technique, LLC. All rights reserved.
//

#import "DefinitionViewController.h"


@implementation DefinitionViewController

@synthesize word;
@synthesize definition;

- (NSString *) escapeForMailto:(NSString *)string {
  return [(NSString*)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,  (CFStringRef)string, NULL,  CFSTR("?=&+"), kCFStringEncodingUTF8) autorelease];
}

- (IBAction) emailDefinition {
  NSLog(@"Emailing definition for %@", word);

  NSString *subject = [self escapeForMailto:[NSString stringWithFormat:@"Devil's Definition: %@", word]];
  NSString *body = [self escapeForMailto:[NSString stringWithFormat:@"Here is a definition I thought you'd like from the Devil's Dictionary.\n\n%@\n\n%@", word, definition]];
  
  NSString *mailto = [NSString stringWithFormat:@"mailto:?subject=%@&body=%@", subject, body];
  NSURL *url = [NSURL URLWithString:mailto];
  if (![[UIApplication sharedApplication] openURL:url]) {
    NSLog(@"Could not open the url %@", mailto);
  }
}

- (void)viewDidLoad {
  self.navigationItem.title = word;
  nameLabel.text = word;
  definitionView.text = definition;
  [super viewDidLoad];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
    self.hidesBottomBarWhenPushed = YES;
  }
  return self;
}

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


- (void)dealloc {
  [word release];
  [definition release];
  [nameLabel release];
  [definitionView release];
  [super dealloc];
}


@end
