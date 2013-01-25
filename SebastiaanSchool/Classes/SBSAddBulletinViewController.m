//
//  SBSAddBulletinViewController.m
//  SebastiaanSchool
//
//  Created by Jeroen Leenarts on 25-01-13.
//
//

#import "SBSAddBulletinViewController.h"

@interface SBSAddBulletinViewController ()
@property (nonatomic, strong) UITextField *titleField;
@property (nonatomic, strong) UITextField *bodyField;
@end

@implementation SBSAddBulletinViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Add Bulletin", nil);
    }
    return self;
}

- (void)loadView{
    [super loadView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonItemStyleDone target:self action:@selector(doneButtonPressed:)];
        
    CGRect bounds = self.view.bounds;
    
    self.titleField = [[UITextField alloc]initWithFrame:CGRectMake(10, 10, bounds.size.width - 20, 26)];
    self.titleField.placeholder = NSLocalizedString(@"Title", nil);
    self.titleField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.titleField];
    
    self.bodyField = [[UITextField alloc]initWithFrame:CGRectMake(10, 52, bounds.size.width - 20, 26)];
#warning add placeholder? http://stackoverflow.com/questions/1328638/placeholder-in-uitextview
    self.bodyField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.bodyField];
}

-(void)doneButtonPressed:(id) sender {
    PFObject *newBulletin = [PFObject objectWithClassName:@"Bulletin"];
    [newBulletin setObject:self.titleField.text forKey:@"title"];
    [newBulletin setObject:self.bodyField.text forKey:@"body"];

    [self.delegate createdBulletin:newBulletin];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
