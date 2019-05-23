# MIQTestingFrameworks
## [DEPRECATED][UNMAINTAINED]

An iOS framework including prebuilt unit testing libraries including:

* [expecta](https://github.com/specta/expecta)
    Simple expectations framework
* [specta](https://github.com/specta/specta)
    A light-weight TDD / BDD framework for Objective-C.
* [OCMock](https://github.com/erikdoe/ocmock)
    Objective-C mock framework. Solid but limited
* [OHHTTPStubs](https://github.com/AliSoftware/OHHTTPStubs)
    Network stubbing library

## Other features
The `MIQTestingFramework.h` header contains headers for all frameworks built in as well as any helpful test classes in the library. It also includes the `TEST_CASE` and `TEST_CASE_WITH_SUBCLASS` macros.

## Included classes
`MIQCoreDataTestBase` is a simple base class for unit testing Core Data functionality. It finds the model contained in your main bundle and creates an in-memory persistent store. Use the `managedObjectContext` property to pass in to your Core Data dependent classes and methods.

## Building from Source
For reasons of my own sanity, it proved easier to add some of these libraries as cocoapods dependencies rather than submodules. You'll need to make sure you've got cocoapods installed (`gem install cocoapods` followed by `pod setup`).

Once that's done, run `pod install`. You'll also need to update the submodules (`git submodule update --init`). You can then open MIQTestingFramework.xcworkspace. Note workspace not project. Then build the Framework target. You'll find the built framework in the root of your built products directory.

I suggest you build the framework and then add it as a binary to the project you wish to test rather than trying to add it as a submodule.

## Using the framework
You need to add `-ObjC` and `-all_load` to `Other Linker Flags`. If you use the `MIQCoreDataTestBase` you may need to link your unit test bundle to CoreData.framework. Then simply add `#import <MIQTestingFramework/MIQTestingFramework.h>` to your test or to your test bundle's PCH file and have all the fun in the world.

## xcodetest
[xcodetest](https://github.com/sgleadow/xcodetest) is also included here as a submodule, as this seems to be a simple and quite clever way to run your unit tests from the command line. Simply follow the instructions in the readme file. If you're using a workspace, you may need to copy and edit the bash script. Again, copy the dependencies to your project.
