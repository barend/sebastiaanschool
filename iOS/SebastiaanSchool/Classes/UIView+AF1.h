// SebastiaanSchool (c) 2014 by Jeroen Leenarts
//
// SebastiaanSchool is licensed under a
// Creative Commons Attribution-NonCommercial 3.0 Unported License.
//
// You should have received a copy of the license along with this
// work.  If not, see <http://creativecommons.org/licenses/by-nc/3.0/>.
//
//  UIView+AF1.h
//  SebastiaanSchool
//
//  Created by Jeroen Leenarts on 20-08-13.
//
//

#import <UIKit/UIKit.h>

@interface UIView (AF1)
// Positive values make the view appear to be above the surface
// Negative values are below.
// The unit is in points
/**
 *  Additional property on UIViews allowing parallax behavior. The intensity is applied to a view on both the X and Y axis.
 */
@property (nonatomic) CGFloat parallaxIntensity;
@end
