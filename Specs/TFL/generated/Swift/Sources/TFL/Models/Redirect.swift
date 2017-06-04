//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation
import JSONUtilities

public class Redirect: JSONDecodable, JSONEncodable, PrettyPrintable {

    public var active: Bool?

    public var longUrl: String?

    public var shortUrl: String?

    public init(active: Bool? = nil, longUrl: String? = nil, shortUrl: String? = nil) {
        self.active = active
        self.longUrl = longUrl
        self.shortUrl = shortUrl
    }

    public required init(jsonDictionary: JSONDictionary) throws {
        active = jsonDictionary.json(atKeyPath: "active")
        longUrl = jsonDictionary.json(atKeyPath: "longUrl")
        shortUrl = jsonDictionary.json(atKeyPath: "shortUrl")
    }

    public func encode() -> JSONDictionary {
        var dictionary: JSONDictionary = [:]
        if let active = active {
            dictionary["active"] = active
        }
        if let longUrl = longUrl {
            dictionary["longUrl"] = longUrl
        }
        if let shortUrl = shortUrl {
            dictionary["shortUrl"] = shortUrl
        }
        return dictionary
    }

    /// pretty prints all properties including nested models
    public var prettyPrinted: String {
        return "\(type(of: self)):\n\(encode().recursivePrint(indentIndex: 1))"
    }
}