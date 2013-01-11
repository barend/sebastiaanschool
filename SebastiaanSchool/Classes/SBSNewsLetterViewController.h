//
//  SBSNewsLetterViewController.h
//  SebastiaanSchool
//
//  Created by Jeroen Leenarts on 11-01-13.
//
//

#import <UIKit/UIKit.h>

@interface SBSNewsLetterViewController : UIViewController <UIWebViewDelegate>

- (id)initWithNewsLetter:(PFObject *)newsLetter;

@end
