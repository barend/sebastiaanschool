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
@property (nonatomic, strong) UITextField *detailTextField;
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
    
    self.detailTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 52, bounds.size.width - 20, 26)];
    self.displayNameField.placeholder = NSLocalizedString(@"Description", nil);
    self.detailTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.detailTextField];

    self.emailField = [[UITextField alloc]initWithFrame:CGRectMake(10, 52, bounds.size.width - 20, 26)];
    self.displayNameField.placeholder = NSLocalizedString(@"Email", nil);
    self.emailField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.emailField];
}

-(void)doneButtonPressed:(id) sender {
    SBSContactItem *newTeamMember = [[SBSContactItem alloc]init];
    if (self.displayNameField.text.length !=0 && self.detailTextField.text.length !=0) {
        newTeamMember.displayName = self.displayNameField.text;
        newTeamMember.detailText = self.detailTextField.text;
        newTeamMember.email = self.emailField.text;
        [self.delegate createdTeamMember:newTeamMember];
    }
}

@end
