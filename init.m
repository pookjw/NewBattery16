#import <UIKit/UIKit.h>
#import <substrate.h>

@interface _UIBatteryView : UIView
@property (nonatomic) BOOL showsPercentage;
@end

@interface _UIStaticBatteryView : _UIBatteryView
@property (nonatomic) BOOL showsPercentage;
@end

void (*original_UIStaticBatteryView_setShowsPercentage)(_UIStaticBatteryView *self, SEL cmd, BOOL arg1);
void custom_UIStaticBatteryView_setShowsPercentage(_UIStaticBatteryView *self, SEL cmd, BOOL arg1) {
    original_UIStaticBatteryView_setShowsPercentage(self, cmd, YES);
}

BOOL custom_UIStaticBatteryView_showsPercentage(_UIStaticBatteryView *self, SEL cmd) {
    return YES;
}

__attribute__((constructor)) static void init() {
    @autoreleasepool {
        MSHookMessageEx(NSClassFromString(@"_UIStaticBatteryView"), @selector(setShowsPercentage:), (IMP)&custom_UIStaticBatteryView_setShowsPercentage, (IMP *)&original_UIStaticBatteryView_setShowsPercentage);
        MSHookMessageEx(NSClassFromString(@"_UIStaticBatteryView"), @selector(showsPercentage), (IMP)&custom_UIStaticBatteryView_showsPercentage, NULL);
    }
}