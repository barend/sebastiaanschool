//
//  SBSInfoViewController.m
//  SebastiaanSchool
//
//  Created by Jeroen Leenarts on 12-01-13.
//
//

#import "SBSInfoViewController.h"

@interface SBSInfoViewController ()

@end

@implementation SBSInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [TestFlight passCheckpoint:[NSString stringWithFormat:@"Loaded VC %@", self.title]];
    
    [self applyTitle:@"Team" andWithImageNamed:@"123-id-card" toButton:self.aboutButton];
    [self applyTitle:@"Info" andWithImageNamed:@"123-id-card" toButton:self.infoButton];
    [self applyTitle:@"Contact" andWithImageNamed:@"123-id-card" toButton:self.contactButton];
}

- (void)gotoContact:(id)sender {
    
}

- (void)applyTitle:(NSString *)title andWithImageNamed:(NSString *)imageName toButton:(UIButton*)button {
    UIImage *image = [UIImage imageNamed:imageName];
    
    [button setImage:image forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0.0, -image.size.width, -25.0, 0.0)]; // Left inset is the negative of image width.
    [button setImageEdgeInsets:UIEdgeInsetsMake(-15.0, 0.0, 0.0, -button.titleLabel.bounds.size.width)]; // Right inset is the negative of text bounds width.
}

@end
