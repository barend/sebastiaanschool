//
//  SBSAddTeamMemberViewController.h
//  SebastiaanSchool
//
//  Created by Jeroen Leenarts on 09-02-13.
//
//

@protocol SBSAddTeamMemberDelegate <NSObject>

-(void)createdTeamMember:(PFObject *)newTeamMember;

@end

@interface SBSAddTeamMemberViewController : UIViewController

@property (nonatomic, unsafe_unretained) id<SBSAddTeamMemberDelegate> delegate;

@end
