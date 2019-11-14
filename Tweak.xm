#import <UIKit/UIKit.h>

#import "XMASFallingSnowView.h"
/*
This is the view we are modifying from Snoverlay using initWithFrame method
We can either import the header, or make our own interface with just the properties we are modifying, I chose to just import the header in order to get ideas for other customizations, like custom images...
*/

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

//The k before each variable name denotes we are using this as a stored object inside the prefs dictionary, or in this case user defaults plist
static float kFlakeCount = 160;
static BOOL kEnabled;
static BOOL kDoubleSized;
static BOOL kHalfSized;
static BOOL kSlowAnimation;
static BOOL kSnowHarder;
 
//Used BOOL variables instead of bool in case I decide to switch to Cephei for loading prefs and handling callbacks.


%group mainTweak

%hook XMASFallingSnowView
- (id)initWithFrame:(CGRect)frame {
   %orig;
    if(kEnabled) {  //If and only if customizer tweak is on, make the following changes:

self.flakesCount= kFlakeCount; //This is the value returned by the slider we used

if(kDoubleSized) {     
 /*
These values are double the default values used in Snoverlay tweak; note that if both buttons are pressed, the next one will ultimately be the values used.
Since either way one of them will be used, and if neither are pressed it skips this code, I didn't check for if both. We could add a UIAlert in the settings to ask
which one they want, warning them that only the second set of values are used, but decided to just keep this simple.
*/

self.flakeWidth= 40.f;
self.flakeHeight= 46.f;

   }

if(kHalfSized) {  
 //These are for the "Tiny snowflakes" option, roughly half the default value sizes from Snoverlay

self.flakeWidth= 10.f;
self.flakeHeight= 12.f;

   }

if(kSlowAnimation) {                 
 //If user selected the "slower animation", use these values. We could add sliders for this and size to give complete control.

self.animationDurationMin = 12.f;
self.animationDurationMax =24.f;

   }

if(kSnowHarder) {
// Animation speeds for if user wants to slow down the normal animation speed. 
// If neither kSnowHarder or kSlowAnimation is picked, it doesn't modify that part of Snoverlay.

self.animationDurationMin = 4.f;
self.animationDurationMax = 8.f;

   }
    return self; 
  } //end of if(kEnabled) 
  return self;
} //end of method initWithFrame:

%end //End of view we are hooking to make the changes at initialization
%end //End of group mainTweak


static void loadPrefs()
{
        static NSUserDefaults *prefs = [[NSUserDefaults alloc]
                                    initWithSuiteName:@"com.i0stweak3r.snoverlaycustomizer"];


        kEnabled = [prefs boolForKey:@"Enabled"];
//Simplest way of using user defaults for bool variables

        kDoubleSized = [prefs boolForKey:@"doubleSized"];

        
     kHalfSized = [prefs boolForKey:@"halfSized"];

        
        kSlowAnimation = [prefs boolForKey:@"slowAnimation"];

        
         kSnowHarder = [prefs objectForKey:@"snowHarder"] ? [prefs boolForKey:@"snowHarder"] : NO; 
//This way checks if the is value stored for snowHarder or it uses NO for the tweak
        
      kFlakeCount = [prefs objectForKey:@"flakeCount"] ? [[prefs objectForKey:@"flakeCount"] floatValue] : kFlakeCount;
//This is for the slider, if there is a stored value for the key, then it uses flakecount value saved in user defaults, else it uses same value it had before
    }




%ctor {
    CFNotificationCenterAddObserver(
                                    CFNotificationCenterGetDarwinNotifyCenter(), NULL,
                                    (CFNotificationCallback)loadPrefs,
                                  CFSTR("com.i0stweak3r.snoverlaycustomizer/ReloadPrefs"), NULL,
                                    CFNotificationSuspensionBehaviorDeliverImmediately);

//Lets check if Snoverlay is installed, and only use the hooks and fetch preference values if it is, as the tweak is useless without Snoverlay

    NSString *snoverlayTweakPath = @"/Library/MobileSubstrate/DynamicLibraries/Snoverlay.dylib";
    bool hasSnoverlayInstalled = ([[NSFileManager defaultManager] fileExistsAtPath: snoverlayTweakPath] ? YES : NO);

      if(hasSnoverlayInstalled) {
        loadPrefs();
        %init(mainTweak);
          }
        else  { 
      NSUserDefaults *validate = [[NSUserDefaults alloc] initWithSuiteName:@"com.i0stweak3r.snoverlaycustomizer"];
      NSString *alreadyWarned = @"already_warned";
      if([validate boolForKey:alreadyWarned]) return;
 //Check if the alert has already been shown, so the user isn't hounded by constant alerts. 

//Once shown, set to YES for already warned.
     [validate setBool:YES forKey:alreadyWarned];

     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Depends Not Installed" 
message:@"You need to install Snoverlay from BigBoss, the version by leftyfl1p, for SnoverlayCustomizer to work." delegate:nil 
cancelButtonTitle:@"Thanks for the warning" otherButtonTitles:nil];
[alert show];
[alert release];

//This UIAlert is old way. Sorry just did it from memory. Will fix using the new way soon.

              }  // end of if Snoverlay is not installed
     } //End of %ctor





