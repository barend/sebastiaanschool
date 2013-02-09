//
//  SBSAddTeamMemberViewController.m
//  SebastiaanSchool
//
//  Created by Jeroen Leenarts on 09-02-13.
//
//

#import "SBSAddTeamMemberViewController.h"

@interface SBSAddTeamMemberViewController ()
@property (nonatomic, strong) UITextField *displayNameField;
@property (nonatomic, strong) UITextField *descriptionField;
@end

@implementation SBSAddTeamMemberViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Add team member", nil);
    }
    return self;
}

- (void)loadView{
    [super loadView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonItemStyleDone target:self action:@selector(doneButtonPressed:)];
        
    CGRect bounds = self.view.bounds;
    
    self.displayNameField = [[UITextField alloc]initWithFrame:CGRectMake(10, 10, bounds.size.width - 20, 26)];
    self.displayNameField.placeholder = NSLocalizedString(@"Title", nil);
    self.displayNameField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.displayNameField];
    
    self.descriptionField = [[UITextField alloc]initWithFrame:CGRectMake(10, 52, bounds.size.width - 20, 26)];
#warning add placeholder? http://stackoverflow.com/questions/1328638/placeholder-in-uitextview
    self.descriptionField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.descriptionField];
}

-(void)doneButtonPressed:(id) sender {
    PFObject *newTeamMember = [PFObject objectWithClassName:@"ContactItem"];
    if (self.displayNameField.text.length !=0 && self.descriptionField.text.length !=0) {
        [newTeamMember setObject:self.displayNameField.text forKey:@"displayName"];
        [newTeamMember setObject:self.descriptionField.text forKey:@"description"];
        
        [self.delegate createdTeamMember:newTeamMember];
    }
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
