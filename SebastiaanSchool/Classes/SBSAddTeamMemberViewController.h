//
//  SBSAddTeamMemberViewController.h
//  SebastiaanSchool
//
//  Created by Jeroen Leenarts on 09-02-13.
//
//

#import "SBSContactItem.h"

@protocol SBSAddTeamMemberDelegate <NSObject>

-(void)createdTeamMember:(SBSContactItem *)newTeamMember;

@end

@interface SBSAddTeamMemberViewController : UIViewController

@property (nonatomic, unsafe_unretained) id<SBSAddTeamMemberDelegate> delegate;

@end
