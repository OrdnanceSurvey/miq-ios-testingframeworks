# MIQTestingFrameworks
An iOS framework including prebuilt unit testing libraries including:

* [expecta](https://github.com/petejkim/expecta)
    Simple expectations framework
* [OCMock](https://github.com/erikdoe/ocmock)
    Objective-C mock framework. Solid but limited
* [LRMocky](https://github.com/lukeredpath/LRMocky)
    Objective-C port of jMock. Fuller featured, but not as battle hardened
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

## xcodetest
[xcodetest](https://github.com/sgleadow/xcodetest) is also included here as a submodule, as this seems to be a simple and quite clever way to run your unit tests from the command line. Simply follow the instructions in the readme file. If you're using a workspace, you may need to copy and edit the bash script. Again, copy the dependencies to your project.
