//
//  SBSEditBulletinViewController.h
//  SebastiaanSchool
//
//  Created by Jeroen Leenarts on 22-03-13.
//
//

#import <UIKit/UIKit.h>

@protocol SBSEditBulletinDelegate <NSObject>

-(void)createBulletin:(PFObject *)newBulletin;
-(void)updateBulletin:(PFObject *)updatedBulletin;
-(void)deleteBulletin:(PFObject *)deletedBulletin;

@end

@interface SBSEditBulletinViewController : UIViewController <UIActionSheetDelegate>

@property (nonatomic, weak) id<SBSEditBulletinDelegate> delegate;
@property (nonatomic, strong)PFObject * bulletin;

@end
