//
//  SBSEditBulletinViewController.m
//  SebastiaanSchool
//
//  Created by Jeroen Leenarts on 22-03-13.
//
//

#import "SBSEditBulletinViewController.h"

//@interface SBSEditBulletinViewController ()
//@property (nonatomic, strong) UITextField *titleField;
//@property (nonatomic, strong) UITextField *bodyField;
//
//@end

@implementation SBSEditBulletinViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Bulletin", nil);
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed:)];
    
    //    CGRect bounds = self.view.bounds;
    
    //    self.titleField = [[UITextField alloc]initWithFrame:CGRectMake(10, 10, bounds.size.width - 20, 26)];
    //    self.titleField.placeholder = NSLocalizedString(@"Title", nil);
    //    self.titleField.borderStyle = UITextBorderStyleRoundedRect;
    //    [self.view addSubview:self.titleField];
    //
    //    self.bodyField = [[UITextField alloc]initWithFrame:CGRectMake(10, 52, bounds.size.width - 20, 26)];
    //    self.bodyField.borderStyle = UITextBorderStyleRoundedRect;
    //    [self.view addSubview:self.bodyField];
}

-(void)doneButtonPressed:(id) sender {
//    PFObject *newBulletin = [PFObject objectWithClassName:@"Bulletin"];
//    if (self.titleField.text.length !=0) {
//        [newBulletin setObject:self.titleField.text forKey:@"title"];
//        if (self.bodyField.text.length !=0) {
//            [newBulletin setObject:self.bodyField.text forKey:@"body"];
//        }
//        [self.delegate createBulletin:newBulletin];
//    }
}

@end

