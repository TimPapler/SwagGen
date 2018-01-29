//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation
import JSONUtilities

public class AccessToken: JSONDecodable, JSONEncodable, PrettyPrintable {

    /** The token value used for authenticated requests. */
    public var value: String

    /** True if this token can be refreshed, false if not. */
    public var refreshable: Bool

    /** The timestamp this token expires. */
    public var expirationDate: Date

    /** The type of the token. */
    public var type: `Type`

    public init(value: String, refreshable: Bool, expirationDate: Date, type: `Type`) {
        self.value = value
        self.refreshable = refreshable
        self.expirationDate = expirationDate
        self.type = type
    }

    public required init(jsonDictionary: JSONDictionary) throws {
        value = try jsonDictionary.json(atKeyPath: "value")
        refreshable = try jsonDictionary.json(atKeyPath: "refreshable")
        expirationDate = try jsonDictionary.json(atKeyPath: "expirationDate")
        type = try jsonDictionary.json(atKeyPath: "type")
    }

    public func encode() -> JSONDictionary {
        var dictionary: JSONDictionary = [:]
        dictionary["value"] = value
        dictionary["refreshable"] = refreshable
        dictionary["expirationDate"] = expirationDate.encode()
        dictionary["type"] = type.encode()
        return dictionary
    }

    /// pretty prints all properties including nested models
    public var prettyPrinted: String {
        return "\(Swift.type(of: self)):\n\(encode().recursivePrint(indentIndex: 1))"
    }
}

extension AccessToken {

    /** The type of the token. */
    public enum `Type`: String {
        case userAccount = "UserAccount"
        case userProfile = "UserProfile"

        public static let cases: [`Type`] = [
          .userAccount,
          .userProfile,
        ]
    }

}
