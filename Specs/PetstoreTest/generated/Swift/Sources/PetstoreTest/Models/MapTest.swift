//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation
import JSONUtilities

public class MapTest: JSONDecodable, JSONEncodable, PrettyPrintable {

    public var mapMapOfString: [String: [String: String]]?

    public var mapOfEnumString: [String: MapOfEnumString]?

    public init(mapMapOfString: [String: [String: String]]? = nil, mapOfEnumString: [String: MapOfEnumString]? = nil) {
        self.mapMapOfString = mapMapOfString
        self.mapOfEnumString = mapOfEnumString
    }

    public required init(jsonDictionary: JSONDictionary) throws {
        mapMapOfString = jsonDictionary.json(atKeyPath: "map_map_of_string")
        mapOfEnumString = jsonDictionary.json(atKeyPath: "map_of_enum_string")
    }

    public func encode() -> JSONDictionary {
        var dictionary: JSONDictionary = [:]
        if let mapMapOfString = mapMapOfString?.mapValues({ $0.encode() }) {
            dictionary["map_map_of_string"] = mapMapOfString
        }
        if let mapOfEnumString = mapOfEnumString?.encode() {
            dictionary["map_of_enum_string"] = mapOfEnumString
        }
        return dictionary
    }

    /// pretty prints all properties including nested models
    public var prettyPrinted: String {
        return "\(Swift.type(of: self)):\n\(encode().recursivePrint(indentIndex: 1))"
    }
}

extension MapTest {

    public enum MapOfEnumString: String {
        case upper = "UPPER"
        case lower = "lower"

        public static let cases: [MapOfEnumString] = [
          .upper,
          .lower,
        ]
    }

}
