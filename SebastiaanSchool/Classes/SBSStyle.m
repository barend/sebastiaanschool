//
//  SBSStyle.m
//  SebastiaanSchool
//
//  Created by Jeroen Leenarts on 11-01-13.
//
//

#import "SBSStyle.h"

static UIColor * sebastiaanBlueColor;
static NSDateFormatter * longStyleDateFormatter;


@implementation SBSStyle

+ (void)initialize {
    if ([SBSStyle class] == self) {
        sebastiaanBlueColor = [UIColor colorWithRed:0.0f green:0.67058823499999998f blue:0.90196078400000002f alpha:1.0];
        
        longStyleDateFormatter = [[NSDateFormatter alloc] init];
        [longStyleDateFormatter setDateStyle:NSDateFormatterLongStyle];
    }
}

+ (UIColor *)sebastiaanBlueColor {
    return sebastiaanBlueColor;
}

+ (NSDateFormatter *)longStyleDateFormatter {
    return longStyleDateFormatter;
}

+ (UIView *)selectedBackgroundView {
    UIView * const newSelectedBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    newSelectedBackgroundView.backgroundColor = [SBSStyle sebastiaanBlueColor];
    newSelectedBackgroundView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    return newSelectedBackgroundView;
}

@end
