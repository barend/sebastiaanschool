//
//  SBSInfoViewController.h
//  SebastiaanSchool
//
//  Created by Jeroen Leenarts on 12-01-13.
//
//

@interface SBSInfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *callButton;
@property (weak, nonatomic) IBOutlet UIButton *infoButton;
@property (weak, nonatomic) IBOutlet UIButton *aboutButton;
@property (weak, nonatomic) IBOutlet UIButton *teamButton;

- (IBAction)buttonTapped:(id)sender;
@end
