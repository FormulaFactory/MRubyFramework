# MRubyFramework

## Installation

MRubyFramework is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MRubyFramework', '2.1.2.1'
```

## Build Your Framework
MRubyFramework support build mruby 2.x and 3.x, but 2.x is stable.  
if you want to build your mruby framework, mruby 2.x is first choic.  

the `build_config.rb` file is a configuration of mruby building.
the `Rakefile` file is a task file that building mruby.

1. clone the repo
``` bash
git clone --recursive git@github.com:FormulaFactory/MRubyFramework.git
```
2. select mruby version
``` base
    rake mruby_master # use mruby master branch

    # OR
    rake mruby_stable # use mruby stable branch

    # OR
    cd mruby 
    git checkout branch_or_tag
    git pull --rebase
```
3. build mruby framework
``` base
rake

#OR
rake build_mruby
```

## Author

ping.cao

## License

MRubyFramework is available under the MIT license. See the LICENSE file for more info.
