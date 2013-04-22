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

+ (CGFloat)heightForWidth:(CGFloat)width withItem:(SBSBulletin *)object
{
    if (object == nil) {
        return 0.0f;
    }
    CGFloat availableWidth = width - [SBSStyle standardMargin] *2;
    
    NSString *title = object.title;
    NSString *createdAt = [[SBSStyle longStyleDateFormatter] stringFromDate:object.createdAt];
    NSString *body = object.body;
    
    CGFloat height = [SBSStyle standardMargin];
    
    height += [title sizeWithFont:[SBSStyle titleFont] constrainedToSize:CGSizeMake(availableWidth, CGFLOAT_MAX)].height;
    height += [createdAt sizeWithFont:[SBSStyle subtitleFont] constrainedToSize:CGSizeMake(availableWidth, CGFLOAT_MAX)].height;
    if (body != nil) {
        height += [body sizeWithFont:[SBSStyle bodyFont] constrainedToSize:CGSizeMake(availableWidth, CGFLOAT_MAX)].height;
    }
    
    height += [SBSStyle standardMargin];
    
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
    self.textLabel._y = [SBSStyle standardMargin];
    self.detailTextLabel._y = self.textLabel._bottom;
    
    if (self.bodyLabel.text == nil) {
        self.bodyLabel.frame = CGRectZero;
    } else {
        self.bodyLabel.frame = self.bounds;
        self.bodyLabel._y = self.detailTextLabel._bottom;
        self.bodyLabel._left = [SBSStyle standardMargin];
        self.bodyLabel._width = self.bodyLabel._width - [SBSStyle standardMargin];
        self.bodyLabel._height = self.bounds.size.height - self.bodyLabel._y - [SBSStyle standardMargin];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
