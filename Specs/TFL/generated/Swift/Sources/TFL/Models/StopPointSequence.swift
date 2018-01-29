//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation
import JSONUtilities

public class StopPointSequence: JSONDecodable, JSONEncodable, PrettyPrintable {

    /** The id of this branch. */
    public var branchId: Int?

    public var direction: String?

    public var lineId: String?

    public var lineName: String?

    /** The ids of the next branch(es) in the sequence. Note that the next and previous branch id can be
            identical in the case of a looped route e.g. the Circle line. */
    public var nextBranchIds: [Int]?

    /** The ids of the previous branch(es) in the sequence. Note that the next and previous branch id can be
            identical in the case of a looped route e.g. the Circle line. */
    public var prevBranchIds: [Int]?

    public var serviceType: ServiceType?

    public var stopPoint: [MatchedStop]?

    public init(branchId: Int? = nil, direction: String? = nil, lineId: String? = nil, lineName: String? = nil, nextBranchIds: [Int]? = nil, prevBranchIds: [Int]? = nil, serviceType: ServiceType? = nil, stopPoint: [MatchedStop]? = nil) {
        self.branchId = branchId
        self.direction = direction
        self.lineId = lineId
        self.lineName = lineName
        self.nextBranchIds = nextBranchIds
        self.prevBranchIds = prevBranchIds
        self.serviceType = serviceType
        self.stopPoint = stopPoint
    }

    public required init(jsonDictionary: JSONDictionary) throws {
        branchId = jsonDictionary.json(atKeyPath: "branchId")
        direction = jsonDictionary.json(atKeyPath: "direction")
        lineId = jsonDictionary.json(atKeyPath: "lineId")
        lineName = jsonDictionary.json(atKeyPath: "lineName")
        nextBranchIds = jsonDictionary.json(atKeyPath: "nextBranchIds")
        prevBranchIds = jsonDictionary.json(atKeyPath: "prevBranchIds")
        serviceType = jsonDictionary.json(atKeyPath: "serviceType")
        stopPoint = jsonDictionary.json(atKeyPath: "stopPoint")
    }

    public func encode() -> JSONDictionary {
        var dictionary: JSONDictionary = [:]
        if let branchId = branchId {
            dictionary["branchId"] = branchId
        }
        if let direction = direction {
            dictionary["direction"] = direction
        }
        if let lineId = lineId {
            dictionary["lineId"] = lineId
        }
        if let lineName = lineName {
            dictionary["lineName"] = lineName
        }
        if let nextBranchIds = nextBranchIds {
            dictionary["nextBranchIds"] = nextBranchIds
        }
        if let prevBranchIds = prevBranchIds {
            dictionary["prevBranchIds"] = prevBranchIds
        }
        if let serviceType = serviceType?.encode() {
            dictionary["serviceType"] = serviceType
        }
        if let stopPoint = stopPoint?.encode() {
            dictionary["stopPoint"] = stopPoint
        }
        return dictionary
    }

    /// pretty prints all properties including nested models
    public var prettyPrinted: String {
        return "\(Swift.type(of: self)):\n\(encode().recursivePrint(indentIndex: 1))"
    }
}

extension StopPointSequence {

    public enum ServiceType: String {
        case regular = "Regular"
        case night = "Night"

        public static let cases: [ServiceType] = [
          .regular,
          .night,
        ]
    }

}
