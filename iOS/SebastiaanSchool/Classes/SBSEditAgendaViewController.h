// SebastiaanSchool (c) 2014 by Jeroen Leenarts
//
// SebastiaanSchool is licensed under a
// Creative Commons Attribution-NonCommercial 3.0 Unported License.
//
// You should have received a copy of the license along with this
// work.  If not, see <http://creativecommons.org/licenses/by-nc/3.0/>.
//
//  SBSEditAgendaViewController.h
//  SebastiaanSchool
//
//  Created by Jeroen Leenarts on 21-04-13.
//
//

#import "SBSBaseEditViewController.h"

#import "SBSAgendaItem.h"

@protocol SBSEditAgendaItemDelegate <NSObject>

-(void)createAgendaItem:(SBSAgendaItem *)agendaItem;
-(void)updateAgendaItem:(SBSAgendaItem *)agendaItem;
-(void)deleteAgendaItem:(SBSAgendaItem *)agendaItem;

@end

@interface SBSEditAgendaViewController : SBSBaseEditViewController

@property (nonatomic, weak) id<SBSEditAgendaItemDelegate> delegate;
@property (nonatomic, strong)SBSAgendaItem * agendaItem;

@end
