# Abandoned Resource String Detection
This command line program detects unused resource strings in an iOS or OS X application.

## Usage
Open a Terminal to the directory which contains the *AbandonedStrings* executable, and run the following command:

`$ ./AbandonedStrings /Users/your-username/path/to/source/code`

## What to expect
If a `.strings` file contains… 

`"some_string_identifier" = "Some Display Text";`

…this program will consider that resource string to be abandoned if…

`"some_string_identifier"`

…is not found in any of the source code files (namely, files with a `.h`, `.m`, or `.swift` extension).

## More details
This program searches through the source code files in an iOS app project, looking for resource strings (in a `.strings` file) whose identifiers are not referenced by the application's source code. 

The search logic does not take into account if code is commented out, so it can produce false positives if your application has a lot of commented-out code. 

It also does not try to determine the context in which string identifiers are used, such as whether or not the string is being used to look up a localized string value or if it just happens to match a resource string identifier by coincidence. 

Also, this program is ineffective if resource string identifiers are referenced via constants.

## Disclaimer
As noted above, this program can yield false positives. Be sure to verify that a resource string is not being used before removing it from your app.