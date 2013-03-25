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

static UIFont * titleFont;
static UIFont * subtitleFont;
static UIFont * bodyFont;

@implementation SBSStyle

+ (void)initialize {
    if ([SBSStyle class] == self) {
        sebastiaanBlueColor = [UIColor colorWithRed:0.0f green:0.67058823499999998f blue:0.90196078400000002f alpha:1.0];
        
        longStyleDateFormatter = [[NSDateFormatter alloc] init];
        [longStyleDateFormatter setDateStyle:NSDateFormatterLongStyle];
        
        titleFont = [UIFont boldSystemFontOfSize:[UIFont labelFontSize] +1.0f];
        subtitleFont = [UIFont systemFontOfSize:[UIFont systemFontSize]];
        bodyFont = [UIFont systemFontOfSize:[UIFont systemFontSize] +2.0f];
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

+ (UIFont *)titleFont {
    return titleFont;
}

+ (UIFont *)subtitleFont {
    return subtitleFont;
}

+ (UIFont *)bodyFont {
    return bodyFont;
}

+ (CGFloat)phoneWidth {
    return 320.0f;
}

+ (CGFloat)standardMargin {
    return 10.0f;
}

@end
