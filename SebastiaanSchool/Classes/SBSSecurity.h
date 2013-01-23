//
//  SBSSecurity.h
//  SebastiaanSchool
//
//  Created by Jeroen Leenarts on 20-01-13.
//
//

#import <Foundation/Foundation.h>

@interface SBSSecurity : NSObject
@property (nonatomic, readonly) BOOL isCurrentUserStaffUser;

+(SBSSecurity *)instance;
@end
