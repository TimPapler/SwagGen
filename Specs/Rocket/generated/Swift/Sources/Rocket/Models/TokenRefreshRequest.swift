//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation
import JSONUtilities

public class TokenRefreshRequest: JSONDecodable, JSONEncodable, PrettyPrintable {

    /** The token to refresh. */
    public var token: String

    /** If you specify a cookie type then a content filter cookie will be returned
along with the token(s). This is only really intended for web based clients which
need to pass the cookies to a server to render a page based on the users
content filters, e.g subscription code.

If type `Session` the cookie will be session based.
If type `Persistent` the cookie will have a medium term lifespan.
If undefined no cookies will be set.
 */
    public var cookieType: CookieType?

    public init(token: String, cookieType: CookieType? = nil) {
        self.token = token
        self.cookieType = cookieType
    }

    public required init(jsonDictionary: JSONDictionary) throws {
        token = try jsonDictionary.json(atKeyPath: "token")
        cookieType = jsonDictionary.json(atKeyPath: "cookieType")
    }

    public func encode() -> JSONDictionary {
        var dictionary: JSONDictionary = [:]
        dictionary["token"] = token
        if let cookieType = cookieType?.encode() {
            dictionary["cookieType"] = cookieType
        }
        return dictionary
    }

    /// pretty prints all properties including nested models
    public var prettyPrinted: String {
        return "\(Swift.type(of: self)):\n\(encode().recursivePrint(indentIndex: 1))"
    }
}

extension TokenRefreshRequest {

    /** If you specify a cookie type then a content filter cookie will be returned
    along with the token(s). This is only really intended for web based clients which
    need to pass the cookies to a server to render a page based on the users
    content filters, e.g subscription code.

    If type `Session` the cookie will be session based.
    If type `Persistent` the cookie will have a medium term lifespan.
    If undefined no cookies will be set.
     */
    public enum CookieType: String {
        case session = "Session"
        case persistent = "Persistent"

        public static let cases: [CookieType] = [
          .session,
          .persistent,
        ]
    }

}
