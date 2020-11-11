# Ravn Challenge V2
App that retrieves and shows information for diverse characters in the StarWars World.

# Requeriments:
* Xcode 12.0 or greater
* iOS 14 or greater

# Dependencies & Technologies used
* Apollo
* SwiftUI
* Combine
* Swiftlint (For linting, you should see linting in code if installed)
    * For install: 
    ```
    brew install swiftlint
    ```

# Assumptions
* Disabled DarkMode support in the app to match design
* In the list of characters, some characters doesn't have species, in that case just show the homeWorld of the character composing a string like `"From Tatooine"` if no species, or `"Human from Tatooine"` if all the information is complete.

# How to run the project?:
* Open the RavnChallengeV2.xcodeproj or go to the root of the project in the terminal and execute `xed .`
* Wait for the download process of the dependencies to finish (in the left panel)
* Select the simulator you want to run on, or connect your device (with iOS 14+) and run it
    * In case you use a physical device you may need to set a Team in project configuration.

# Demo
