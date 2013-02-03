//
//  SBSAddBulletinViewController.h
//  SebastiaanSchool
//
//  Created by Jeroen Leenarts on 25-01-13.
//
//

@protocol SBSAddBulletinDelegate <NSObject>

-(void)createdBulletin:(PFObject *)newBulletin;

@end

@interface SBSAddBulletinViewController : UIViewController

@property (nonatomic, unsafe_unretained) id<SBSAddBulletinDelegate> delegate;

@end
