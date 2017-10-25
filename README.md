# ResxSwift

[![CI Status](http://img.shields.io/travis/Amnell/ResxSwift.svg?style=flat)](https://travis-ci.org/Amnell/ResxSwift)
[![Version](https://img.shields.io/cocoapods/v/ResxSwift.svg?style=flat)](http://cocoapods.org/pods/ResxSwift)
[![License](https://img.shields.io/cocoapods/l/ResxSwift.svg?style=flat)](http://cocoapods.org/pods/ResxSwift)
[![Platform](https://img.shields.io/cocoapods/p/ResxSwift.svg?style=flat)](http://cocoapods.org/pods/ResxSwift)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

To start using ResxSwift you first need to register your resx resource files:

```swift
guard let filePath_en = Bundle.main.path(forResource: "Resource.en", ofType: "resx") else { fatalError("File load error") }}
ResxSwift.shared.load(fileURL: URL(fileURLWithPath: filePath_en), language: "en", namespace: "Resource")
```

To use your loaded language resources all you need to do is:

```swift
ResxSwift.shared.localizedString("key")
```

### Multiple languages and namespaces/resources

ResxSwift supports multiple languages and namespaces to make it easy for you to load multiple resources without them interfering with each other.

To load multiple resources, just make sure to supply the correct language and, if applicable, namespace.

```swift
guard let resourceFilePath_en = Bundle.main.path(forResource: "Resource.en", ofType: "resx") else { fatalError("File load error") }}
guard let clientFilePath_en = Bundle.main.path(forResource: "Client.en", ofType: "resx") else { fatalError("File load error") }}

ResxSwift.shared.load(fileURL: URL(fileURLWithPath: filePath_en), language: "en", namespace: "Resource")
ResxSwift.shared.load(fileURL: URL(fileURLWithPath: filePath_en), language: "en", namespace: "Client")
```

When loading a resource file you have to supply a language. To reference the language when fetching a localization you just supply the language, like: ```ResxSwift.shared.localizedString("key", language: "en")```

Supplying a `namespace` is optional. If no namespace is supplied ResxSwift will infer namespace by extracting all characters from the filename up until the first period. `Namespace.en.resx` will result in `Namespace` as the namespace. To reference the namespace when fetching a localization you just supply the namespace, like: ```ResxSwift.shared.localizedString("key", namespace: "Namespace")```

#### Default language

ResxSwift supports using a default language.

```swift
ResxSwift.shared.defaultLanguage = "en"
```

**Note** `defaultLanguage` will automatically be set to the initial language loaded.

#### Default namespace

ResxSwift supports using a default namespace.

```swift
ResxSwift.shared.defaultNamespace = "en"
```

**Note** `defaultNamespace` will automatically be set to the initial namespace loaded.

## Installation

ResxSwift is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ResxSwift'
```

## Author

amnell, mathias@apping.se

## License

ResxSwift is available under the MIT license. See the LICENSE file for more info.
