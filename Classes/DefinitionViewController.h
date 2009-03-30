//
//  DefinitionViewController.h
//  DevilsDictionary
//
//  Created by Collin on 3/18/09.
//  Copyright 2009 Nimble Technique, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DefinitionViewController : UIViewController {
  IBOutlet UILabel *nameLabel;
  IBOutlet UITextView *definitionView;
  NSString *word;
  NSString *definition;
}

@property (nonatomic, retain) NSString *word;
@property (nonatomic, retain) NSString *definition;

- (IBAction) emailDefinition;
- (NSString *) escapeForMailto:(NSString *)string;

@end
