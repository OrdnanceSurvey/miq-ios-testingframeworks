#import <Foundation/Foundation.h>

#import "ExpectaObject.h"
#import "ExpectaSupport.h"
#import "EXPMatchers.h"

// Enable shorthand by default
#define expect(...) EXP_expect((__VA_ARGS__))
