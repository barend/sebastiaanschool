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
@property (nonatomic, strong) UITextField *emailField;

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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed:)];
        
    CGRect bounds = self.view.bounds;
    
    self.displayNameField = [[UITextField alloc]initWithFrame:CGRectMake(10, 10, bounds.size.width - 20, 26)];
    self.displayNameField.placeholder = NSLocalizedString(@"Title", nil);
    self.displayNameField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.displayNameField];
    
    self.descriptionField = [[UITextField alloc]initWithFrame:CGRectMake(10, 52, bounds.size.width - 20, 26)];
    self.displayNameField.placeholder = NSLocalizedString(@"Description", nil);
    self.descriptionField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.descriptionField];

    self.emailField = [[UITextField alloc]initWithFrame:CGRectMake(10, 52, bounds.size.width - 20, 26)];
    self.displayNameField.placeholder = NSLocalizedString(@"Email", nil);
    self.emailField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.emailField];
}

-(void)doneButtonPressed:(id) sender {
    SBSContactItem *newTeamMember = [[SBSContactItem alloc]init];
    if (self.displayNameField.text.length !=0 && self.descriptionField.text.length !=0) {
        newTeamMember.displayName = self.displayNameField.text;
        newTeamMember.description = self.descriptionField.text;
        newTeamMember.email = self.emailField.text;
        [self.delegate createdTeamMember:newTeamMember];
    }
}

@end
