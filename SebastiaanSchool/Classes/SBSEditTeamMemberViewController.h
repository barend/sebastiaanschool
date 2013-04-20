//
//  SBSAddTeamMemberViewController.h
//  SebastiaanSchool
//
//  Created by Jeroen Leenarts on 09-02-13.
//
//

#import "SBSContactItem.h"

@protocol SBSAddTeamMemberDelegate <NSObject>

-(void)createTeamMember:(SBSContactItem *)newTeamMember;
-(void)updateTeamMember:(SBSContactItem *)updatedTeamMember;
-(void)deleteTeamMember:(SBSContactItem *)deletedTeamMember;

@end

@interface SBSEditTeamMemberViewController : UIViewController <UIActionSheetDelegate>

@property (nonatomic, unsafe_unretained) id<SBSAddTeamMemberDelegate> delegate;
@property (nonatomic, strong)SBSContactItem * contact;

@end
