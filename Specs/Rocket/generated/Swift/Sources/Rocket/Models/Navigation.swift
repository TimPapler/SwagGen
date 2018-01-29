//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation
import JSONUtilities

public class Navigation: JSONDecodable, JSONEncodable, PrettyPrintable {

    /** The header navigation. */
    public var header: [NavEntry]

    /** The account navigation. */
    public var account: NavEntry?

    /** Copyright information. */
    public var copyright: String?

    /** A map of custom fields defined by a curator for navigation. */
    public var customFields: AnonymousType?

    /** The footer navigation. */
    public var footer: NavEntry?

    public init(header: [NavEntry], account: NavEntry? = nil, copyright: String? = nil, customFields: AnonymousType? = nil, footer: NavEntry? = nil) {
        self.header = header
        self.account = account
        self.copyright = copyright
        self.customFields = customFields
        self.footer = footer
    }

    public required init(jsonDictionary: JSONDictionary) throws {
        header = try jsonDictionary.json(atKeyPath: "header")
        account = jsonDictionary.json(atKeyPath: "account")
        copyright = jsonDictionary.json(atKeyPath: "copyright")
        customFields = jsonDictionary.json(atKeyPath: "customFields")
        footer = jsonDictionary.json(atKeyPath: "footer")
    }

    public func encode() -> JSONDictionary {
        var dictionary: JSONDictionary = [:]
        dictionary["header"] = header.encode()
        if let account = account?.encode() {
            dictionary["account"] = account
        }
        if let copyright = copyright {
            dictionary["copyright"] = copyright
        }
        if let customFields = customFields {
            dictionary["customFields"] = customFields
        }
        if let footer = footer?.encode() {
            dictionary["footer"] = footer
        }
        return dictionary
    }

    /// pretty prints all properties including nested models
    public var prettyPrinted: String {
        return "\(Swift.type(of: self)):\n\(encode().recursivePrint(indentIndex: 1))"
    }
}
