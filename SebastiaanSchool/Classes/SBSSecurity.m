//
//  SBSSecurity.m
//  SebastiaanSchool
//
//  Created by Jeroen Leenarts on 20-01-13.
//
//

#import "SBSSecurity.h"

@implementation SBSSecurity

+(SBSSecurity *)instance {
    static SBSSecurity *instance;
    
    static dispatch_once_t onceToken;
    
    dispatch_once (&onceToken, ^{
        instance = [SBSSecurity new];
    });
    
    return instance;
}

-(BOOL)isCurrentUserStaffUser {
    
    if (![PFAnonymousUtils isLinkedWithUser:[PFUser currentUser]]) {
        //User is anonymous
        return NO;
    }
    
    //TODO do this on background thread with callbacks and all.
    PFQuery *query = [PFRole query];
    [query whereKey:@"name" equalTo:@"staff"];
    
    NSArray *matchingRoles = [query findObjects];
    NSAssert(matchingRoles.count == 1, @"There should be exactly one staff role");
    
    PFQuery *roleQuery = [[matchingRoles[0] relationforKey:@"users"] query];
    
    NSArray * staffUsers = [roleQuery findObjects];
    
    return [staffUsers containsObject:[PFUser currentUser]];
}

@end
