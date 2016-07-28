# configure_extensions

[![RubyGems](https://img.shields.io/gem/v/configure_extensions.svg)](https://rubygems.org/gems/configure_extensions)

#### Automatically enable/disable app extensions from Xcode build
###### Keep your project compiling on multiple versions of Xcode by removing incompatible app extensions from the build

Read [Simultaneous Xcode 7 and Xcode 8 compatibility](http://radex.io/xcode7-xcode8/) for more information about this project.

-------
<p align="center">
    <a href="#features">Features</a> &bull;
    <a href="#usage">Usage</a> &bull;
    <a href="#installation">Installation</a> &bull; 
    <a href="#more-like-this">More info</a>
</p>
-------

## Features

Say you have an iOS app. You want to add some iOS 10 app extensions to the project, but you still need to build for iOS 9, and you want to avoid branching. You [configure your project just right](http://radex.io/xcode7-xcode8/) to allow this, but what do you do with app extensions that only compile with Xcode 8?

Simple! You remove them from the "Target Dependencies" and "Embed App Extensions" build phases of the app target before you commit:

~~~
configure_extensions remove MyApp.xcodeproj MyAppTarget NotificationsUI Intents
~~~

This keeps Xcode 7 compatibility. Want to work on iOS 10 features? Add them back in an instant:

~~~
configure_extensions add MyApp.xcodeproj MyAppTarget NotificationsUI Intents
~~~

No branching necessary.

(You can also use `configure_extensions` to add a "fast mode" to your automated build server that skips compilation of unnecessary app extensions)

## Usage

Here's full syntax of the tool:

~~~
configure_extensions <mode> <project> <app_target> <extensions...>

Add and remove app extensions from Xcode build

mode
   add    - enables passed app extension targets
   remove - disables extensions from being built and embedded in the app

project
   path to the Xcode project file

app_target
   name of the main (app) target in which extensions are to be enabled/disabled

extensions
   names of app extension targets to be enabled/disabled

EXAMPLES

configure_extensions add MyApp.xcodeproj MyApp NotificationsUI Share
configure_extensions remove Foo.xcodeproj Foo-iOS Share
~~~

## Installation

~~~
sudo gem install configure_extensions
~~~

## More like this

If you like `configure_extensions`, be sure to check out ["Simultaneous Xcode 7 and Xcode 8 compatibility"](http://radex.io/xcode7-xcode8/) where I explain in detail how to keep a single Xcode project running on multiple versions of Xcode without branching.

And if you're into Swift, you might also like [SwiftyUserDefaults](https://github.com/radex/SwiftyUserDefaults) and [SwiftyTimer](https://github.com/radex/SwiftyTimer).

### Contributing

If you have comments, complaints or ideas for improvements, feel free to open an issue or a pull request. Or [ping me on Twitter](http://twitter.com/radexp).

### Author and license

Radek Pietruszewski

* [github.com/radex](http://github.com/radex)
* [twitter.com/radexp](http://twitter.com/radexp)
* [radex.io](http://radex.io)
* this.is@radex.io

`configure_extensions` is available under the MIT license. See the LICENSE file for more info.
