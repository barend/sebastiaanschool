//
//  SBSBulletinCell.m
//  SebastiaanSchool
//
//  Created by Jeroen Leenarts on 22-03-13.
//
//

#import "SBSBulletinCell.h"

#import "UIView+JLFrameAdditions.h"

@implementation SBSBulletinCell

+ (CGFloat)heightForWidth:(CGFloat)width withItem:(PFObject *)object
{
    if (object == nil) {
        return 0.0f;
    }
    const CGFloat margin = 10.0f;
    CGFloat availableWidth = width - margin *2;
    
    NSString *title = [object objectForKey:@"title"];
    NSString *publishedAt = [[SBSStyle longStyleDateFormatter] stringFromDate:[object objectForKey:@"publishedAt"]];
    NSString *body = [object objectForKey:@"body"];
    
    CGFloat height = margin;
    
    height += [title sizeWithFont:[SBSStyle titleFont] constrainedToSize:CGSizeMake(availableWidth, CGFLOAT_MAX)].height;
    height += [publishedAt sizeWithFont:[SBSStyle subtitleFont] constrainedToSize:CGSizeMake(availableWidth, CGFLOAT_MAX)].height;
    if (body != nil) {
        height += [body sizeWithFont:[SBSStyle bodyFont] constrainedToSize:CGSizeMake(availableWidth, CGFLOAT_MAX)].height;
    }
    
    height += margin;
    
    return height;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.font = [SBSStyle titleFont];
        self.detailTextLabel.font = [SBSStyle subtitleFont];
        // Initialization code
        _bodyLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        [_bodyLabel setTextColor:[UIColor blackColor]];
        [_bodyLabel setHighlightedTextColor:[UIColor whiteColor]];
        _bodyLabel.font = [SBSStyle bodyFont];
        _bodyLabel.numberOfLines = 0;
        _bodyLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self addSubview:_bodyLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.textLabel._y = 10.0f;
    self.detailTextLabel._y = self.textLabel._bottom;
    
    if (self.bodyLabel.text == nil) {
        self.bodyLabel.frame = CGRectZero;
    } else {
        self.bodyLabel.frame = self.bounds;
        self.bodyLabel._y = self.detailTextLabel._bottom;
        self.bodyLabel._left = 10.0f;
        self.bodyLabel._width = self.bodyLabel._width -10;
        self.bodyLabel._height = self.bounds.size.height - self.bodyLabel._y - 10;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
