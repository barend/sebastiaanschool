//
//  SBSContactViewController.h
//  SebastiaanSchool
//
//  Created by Jeroen Leenarts on 12-01-13.
//
//

#import <MessageUI/MessageUI.h>

#import "SBSAddTeamMemberViewController.h"

@interface SBSTeamTableViewController : PFQueryTableViewController <MFMailComposeViewControllerDelegate, UIActionSheetDelegate, SBSAddTeamMemberDelegate>

@end
