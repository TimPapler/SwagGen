//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation
import JSONUtilities

public class Order: JSONDecodable, JSONEncodable, PrettyPrintable {

    public var complete: Bool?

    public var id: Int?

    public var petId: Int?

    public var quantity: Int?

    public var shipDate: Date?

    /** Order Status */
    public var status: Status?

    public init(complete: Bool? = nil, id: Int? = nil, petId: Int? = nil, quantity: Int? = nil, shipDate: Date? = nil, status: Status? = nil) {
        self.complete = complete
        self.id = id
        self.petId = petId
        self.quantity = quantity
        self.shipDate = shipDate
        self.status = status
    }

    public required init(jsonDictionary: JSONDictionary) throws {
        complete = jsonDictionary.json(atKeyPath: "complete")
        id = jsonDictionary.json(atKeyPath: "id")
        petId = jsonDictionary.json(atKeyPath: "petId")
        quantity = jsonDictionary.json(atKeyPath: "quantity")
        shipDate = jsonDictionary.json(atKeyPath: "shipDate")
        status = jsonDictionary.json(atKeyPath: "status")
    }

    public func encode() -> JSONDictionary {
        var dictionary: JSONDictionary = [:]
        if let complete = complete {
            dictionary["complete"] = complete
        }
        if let id = id {
            dictionary["id"] = id
        }
        if let petId = petId {
            dictionary["petId"] = petId
        }
        if let quantity = quantity {
            dictionary["quantity"] = quantity
        }
        if let shipDate = shipDate?.encode() {
            dictionary["shipDate"] = shipDate
        }
        if let status = status?.encode() {
            dictionary["status"] = status
        }
        return dictionary
    }

    /// pretty prints all properties including nested models
    public var prettyPrinted: String {
        return "\(Swift.type(of: self)):\n\(encode().recursivePrint(indentIndex: 1))"
    }
}

extension Order {

    /** Order Status */
    public enum Status: String {
        case placed = "placed"
        case approved = "approved"
        case delivered = "delivered"

        public static let cases: [Status] = [
          .placed,
          .approved,
          .delivered,
        ]
    }

}