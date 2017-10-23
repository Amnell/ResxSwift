import Foundation
import SWXMLHash

enum ResxSwiftError: Error {
    case unableToInferNamespace
}

public final class ResxSwift {
    
    public static let shared = ResxSwift()
    
    /// The fallback language to try if key is not found for given language
    public var defaultLanguage: String?
    
    /// The default namespace to use
    public var defaultNamespace: String?
    
    /// [Namespace: ["Namespace.Language": [Key:Value]]]
    private var strings = [String: [String : String]]()
    
    init() {
        
    }
    
    
    /// Get the localized string for a given key, namespace and language
    ///
    /// - Parameters:
    ///   - key: `String` key
    ///   - namespace: `String` namespace for the localized resource
    ///   - language: `String` language. Will fallback to `fallbackLanguage` if nil
    /// - Returns: `String`
    public func localizedString(_ key: String, namespace: String? = nil, language: String? = nil) -> String {
        guard let language = (language ?? defaultLanguage) else {
            return key
        }
        
        guard let namespace = (namespace ?? defaultNamespace) else {
            return key
        }
        
        if let string = strings[namespace+"."+language]?[key] {
            return string
        }
        
        return key
    }
    
    
    /// Load a resx file from URL
    ///
    /// - Parameters:
    ///   - fileURL: A local file `URL`
    ///   - language: A `String` representing the language
    ///   - namespace: A `String` representing the namespace.
    /// - Throws: `ResxSwiftError.unableToInferNamespace` if namespace inference failed
    public func load(fileURL: URL, language: String, namespace: String? = nil) throws {
        let namespace = try (namespace ?? self.namespace(fromString: fileURL.lastPathComponent))
        
        guard let xmlString = try? String(contentsOf: fileURL) else { fatalError() }
        let xml = SWXMLHash.parse(xmlString)
        
        let decodedStrings = xml["root"]["data"].all.reduce([String:String](), { (dict, indexer) in
            guard let key = indexer.element?.attribute(by: "name")?.text else { return dict }
            guard let value = indexer.children.first?.element?.text else { return dict }
            
            var dict = dict
            dict[key] = value
            return dict
        })
        
        self.strings[namespace+"."+language] = decodedStrings

        // Set the default language if not set
        if defaultLanguage == nil {
            defaultLanguage = language
        }
        
        // Set the default namespace if not set
        if defaultNamespace == nil {
            defaultNamespace = namespace
        }
    }
    
    
    /// Get the namespace from a string.
    ///
    /// - Parameter string: The `String` to get the namespace from
    /// - Returns: The namespace
    /// - Throws: `ResxSwiftError.unableToInferNamespace`
    private func namespace(fromString string: String) throws -> String {
        if let namespaceSubscript = string.split(separator: ".").first {
            return String(describing: namespaceSubscript)
        }
        else {
            throw ResxSwiftError.unableToInferNamespace
        }
    }
    
}
