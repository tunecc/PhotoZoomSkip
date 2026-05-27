#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <substrate.h>

static BOOL (*orig_shouldSkipDeleteConfirmation)(id self, SEL _cmd);

static BOOL hook_shouldSkipDeleteConfirmation(id self, SEL _cmd) {
    return YES;
}

static void (*orig_setPreferredMaximumZoomScale)(id self, SEL _cmd, double maximumZoomScale);

static void hook_setPreferredMaximumZoomScale(id self, SEL _cmd, double maximumZoomScale) {
    if (orig_setPreferredMaximumZoomScale) {
        orig_setPreferredMaximumZoomScale(self, _cmd, 9999.0);
    }
}

__attribute__((constructor))
static void initPhotoZoomSkip(void) {
    NSLog(@"----PhotoZoomSkip Inject success----");

    Class deleteControllerClass = objc_getClass("PUDeletePhotosActionController");
    if (deleteControllerClass) {
        MSHookMessageEx(deleteControllerClass,
                        @selector(shouldSkipDeleteConfirmation),
                        (IMP)hook_shouldSkipDeleteConfirmation,
                        (IMP *)&orig_shouldSkipDeleteConfirmation);
    }

    Class transformViewClass = objc_getClass("PUUserTransformView");
    if (transformViewClass) {
        MSHookMessageEx(transformViewClass,
                        @selector(_setPreferredMaximumZoomScale:),
                        (IMP)hook_setPreferredMaximumZoomScale,
                        (IMP *)&orig_setPreferredMaximumZoomScale);
    }
}
