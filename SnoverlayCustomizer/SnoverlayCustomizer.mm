#import <objc/runtime.h>
#import <Preferences/PSListController.h>
//#import <Preferences/PSSpecifier.h>
//#import <Preferences/PSTableCell.h>
// "PFHeaderCell.h" has PSSpecifier and PSTableCell in it, and is compiled first
#import <UIKit/UIKit.h>

@interface SnoverlayCustomizerListController: PSListController {
}
@end

@implementation SnoverlayCustomizerListController
- (NSArray *)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"SnoverlayCustomizer" target:self] retain];
	}
	return _specifiers;
}

- (void)twitterlink {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter://user?screen_name=brianvs"]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter://user?screen_name=brianvs"]];
    } else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetbot:///user_profile/brianvs"]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tweetbot:///user_profile/brianvs"]];
    }  else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/brianvs"]];
    }
}

/* Deleted in favor of opening in-app rather then webpage
- (void)twitterlink {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://twitter.com/brianvs"]];
}
 */
@end
