# Abandoned Resource String Detection
This command line program detects unused resource strings in an iOS or OS X application.

## Usage
Open a Terminal to the directory which contains the *AbandonedStrings* executable, and run the following command:

`$ ./AbandonedStrings/main.swift /Users/your-username/path/to/sourcecode_folder /path/to/file_containing_the_strings`

i.e. `$ ./AbandonedStrings/main.swift /Volumes/Alinaa/Development/once-ios /Volumes/Alinaa/Development/DerivedData/once-deecixewwotnzkbyydvhbcsxvvrj/Build/Products/InAppDebug-iphoneos/include/Localizable.h`

Can also be used in Xcode, just hardcode those values like:

`var file = "/Volumes/Alinaa/Development/DerivedData/once-deecixewwotnzkbyydvhbcsxvvrj/Build/Products/InAppDebug-iphoneos/include/Localizable.h"`

`return "/Volumes/Alinaa/Development/once-ios"//c`

or retrieve them programmatically as needed

## What to expect

`Searching for abandoned resource strings…
Looking in 1050 source files ...
---------- Found 284 unused strings ------
["com_once_strings_reviews_man_flow_date_sorry_title", "com_once_strings_label_tutorial_subtitle_2_her", "com_once_strings_label_dm_subscribe_title1", "com_once_strings_label_dm_onboarding_popup_page_three_title", "com_once_strings_label_ratetheapp_why_a_woman", "com_once_strings_label_plans_buy_more_crowns_subtitle", "com_once_strings_title_settings_agerange", "com_once_strings_label_pictures_makefirst", "com_once_strings_label_plans_extra_crowns_deal", "com_once_strings_title_termsofservice", "com_once_strings_buttons_crowns_cool_thanks", "com_once_strings_label_elections_profile_french_presidential_election_blue_part", "com_once_strings_label_match_passedmequestion_him", "com_once_strings_label_dialog_tutoinvite_suggest_her_to_a_friend", "com_once_strings_subtitle_my_description", "com_once_strings_label_chat_need_access_to_location", "com_once_strings_title_my_profile", "com_once_strings_label_settings_areyousuredeletedm", "com_once_strings_subtitle_settings_dedicated_matchmaker", "com_once_strings_startup_button_agreed", "com_once_strings_label_subscription_cancel", "com_once_strings_reviews_man_flow_look_pictures_the_same", "com_once_strings_button_match_like_still_not_interested_her", .....]
---------- Found 284 unused strings ------`
