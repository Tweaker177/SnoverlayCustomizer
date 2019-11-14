#include <Preferences/PSListController.h> 
//PFHeaderCell includes PSSpecifier.h and PSTableCell.h, so no need to import them
//PFHeaderCell.h by Pixel Fire
//http://pixelfire.baileyseymour.com
@class PSTableCell, PSSpecifier;
@interface PFHeaderCell : PSTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(id)identifier specifier:(PSSpecifier *)specifier;

@end

