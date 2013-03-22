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
-(void)deleteBulletin:(PFObject *)updatedBulletin;

@end

@interface SBSEditBulletinViewController : UIViewController

@property (nonatomic, weak) id<SBSEditBulletinDelegate> delegate;

@end
