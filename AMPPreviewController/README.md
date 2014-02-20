## UIKit-AMPAdditions

AMPAddiions bring to you some categories for improve the iOS Development.

# Usage

1. Add the AMPAdditions folder to your project.

2. Import AMPAdditions.h file to your -Prefix.pch file.

3. Add this Frameworks:

- MapKit.framework
- QuartzCore.framework
- CoreImage.framework
- CoreGraphics.framework

# Additions

- MKMapView
- NSArray
- NSObject
- UIActionSheet
- UIAlertView
- UIApplication
- UIColor
- UIDevice
- UIFont
- UIImageView
- UINavigationController
- UISplitViewController
- UIView


# In vendor

- NSDate-Extensions | Erica Sadun | https://github.com/erica/NSDate-Extensions
- UIWebView-RemoveShadow | Mark Rickert | https://github.com/markrickert/UIWebView-RemoveShadow


# Useful Macros
*Included Macros from my project SupportMacros https://github.com/alexito4/SupportMacros*

# Compare System Versions
There are some useful macros for comparing system version.

    if (SYSTEM_VERSION_LESS_THAN(@"6.0")) {
        // ...
    }

See the rest in the AMPMacros.h file.
