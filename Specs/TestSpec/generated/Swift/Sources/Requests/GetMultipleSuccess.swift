//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension TestSpec {

    /** operation with multiple success responses */
    public enum GetMultipleSuccess {

        public static let service = APIService<Response>(id: "getMultipleSuccess", tag: "", method: "GET", path: "/multiple-success", hasBody: false, securityRequirement: SecurityRequirement(type: "test_auth", scopes: ["write"]))

        public final class Request: APIRequest<Response> {

            public init() {
                super.init(service: GetMultipleSuccess.service)
            }
        }

        public enum Response: APIResponseValue, CustomStringConvertible, CustomDebugStringConvertible {
            public typealias SuccessType = User

            /** User response */
            case status200(User)

            /** Empty response */
            case status201

            public var success: User? {
                switch self {
                case .status200(let response): return response
                }
            }

            public var response: Any {
                switch self {
                case .status200(let response): return response
                default: return ()
                }
            }

            public var statusCode: Int {
                switch self {
                case .status200: return 200
                case .status201: return 201
                }
            }

            public var successful: Bool {
                switch self {
                case .status200: return true
                case .status201: return true
                }
            }

            public init(statusCode: Int, data: Data, decoder: ResponseDecoder) throws {
                switch statusCode {
                case 200: self = try .status200(decoder.decode(User.self, from: data))
                case 201: self = .status201
                default: throw APIClientError.unexpectedStatusCode(statusCode: statusCode, data: data)
                }
            }

            public var description: String {
                return "\(statusCode) \(successful ? "success" : "failure")"
            }

            public var debugDescription: String {
                var string = description
                let responseString = "\(response)"
                if responseString != "()" {
                    string += "\n\(responseString)"
                }
                return string
            }
        }
    }
}
