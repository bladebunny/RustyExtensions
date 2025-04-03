# RustyExtensions

// The Swift Programming Language
// https://docs.swift.org/swift-book

# Helpful Commands

##Build - from package root
swift **build** // Debug
swift **build -c release** // Release

##Clean - from package root
swift **package clean** 

##Test - run Swift Package tests.  Note: this does **NOT** run the Xcode project unit or UI tests
swift **test** // All
swift test **-help** // List test options
swift test **list** // List tests

### Most options support regex / simple filtering
swift test **--filter UnitTests** // Test UnitTests target
swift test **--filter IntegrationTests** // Test IntegrationTests target
swift test **--filter RustyExtensionsTests.StringTests** // Test a class
swift test **--skip RustyExtensionsTests.StringTests** // Skip a class


## Linting and formatting using the Swift org's default configuration

If you do not have Xcode 16, install swift-format by `brew install swift-format`
if Xcode 16 -> `swift format lint RustyExtensions -r --strict`
if homebrew installed -> `swift-format lint RustyExtensions -r --strict`

##Note: Format code using Swift org's default configuration
if Xcode 16 -> `swift format RustyExtensions -r -i`
if homebrew installed -> `swift-format format RustyExtensions -r -i`
###Note: Formatting command will not fix all comments, some must be done manually.

##Build Docs
swift **package generate-documentation** // Build all docs
swift **package generate-documentation --target RustyExtensions** // Build only base_sdk docs
swift **package --disable-sandbox preview-documentation --target RustyExtensions** // Preview docs in web browser
   
