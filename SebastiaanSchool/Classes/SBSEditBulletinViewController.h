//
//  SBSEditBulletinViewController.h
//  SebastiaanSchool
//
//  Created by Jeroen Leenarts on 22-03-13.
//
//

#import <UIKit/UIKit.h>

#import "SBSBulletin.h"

@protocol SBSEditBulletinDelegate <NSObject>

-(void)createBulletin:(SBSBulletin *)newBulletin;
-(void)updateBulletin:(SBSBulletin *)updatedBulletin;
-(void)deleteBulletin:(SBSBulletin *)deletedBulletin;

@end

@interface SBSEditBulletinViewController : UIViewController <UIActionSheetDelegate>

@property (nonatomic, weak) id<SBSEditBulletinDelegate> delegate;
@property (nonatomic, strong)SBSBulletin * bulletin;

@end
