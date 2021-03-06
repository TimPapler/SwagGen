//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation
import JSONUtilities

extension TBX.UserService {

    public enum UserServiceLogout {

        public static let service = APIService<Response>(id: "UserService.logout", tag: "UserService", method: "DELETE", path: "/UserServices/device/{device}", hasBody: false)

        public final class Request: APIRequest<Response> {

            public struct Options {

                /** The device token */
                public var device: String

                public init(device: String) {
                    self.device = device
                }
            }

            public var options: Options

            public init(options: Options) {
                self.options = options
                super.init(service: UserServiceLogout.service)
            }

            /// convenience initialiser so an Option doesn't have to be created
            public convenience init(device: String) {
                let options = Options(device: device)
                self.init(options: options)
            }

            public override var path: String {
                return super.path.replacingOccurrences(of: "{" + "device" + "}", with: "\(self.options.device)")
            }
        }

        public enum Response: APIResponseValue, CustomStringConvertible, CustomDebugStringConvertible {
            public typealias SuccessType = Status200

            /** Request was successful */
            case status200(Status200)

            /** Bad Request  */
            case status400(ResponseError)

            /** Unauthorized  */
            case status401(ResponseError)

            /** Customer or Device not Found */
            case status404(ResponseError)

            /** Device was Logged Out or the customer not longer exists */
            case status410(ResponseError)

            public var success: Status200? {
                switch self {
                case .status200(let response): return response
                default: return nil
                }
            }

            public var failure: ResponseError? {
                switch self {
                case .status400(let response): return response
                case .status401(let response): return response
                case .status404(let response): return response
                case .status410(let response): return response
                default: return nil
                }
            }

            /// either success or failure value. Success is anything in the 200..<300 status code range
            public var responseResult: APIResponseResult<Status200, ResponseError> {
                if let successValue = success {
                    return .success(successValue)
                } else if let failureValue = failure {
                    return .failure(failureValue)
                } else {
                    fatalError("Response does not have success or failure response")
                }
            }

            public var response: Any {
                switch self {
                case .status200(let response): return response
                case .status400(let response): return response
                case .status401(let response): return response
                case .status404(let response): return response
                case .status410(let response): return response
                }
            }

            public var statusCode: Int {
                switch self {
                case .status200: return 200
                case .status400: return 400
                case .status401: return 401
                case .status404: return 404
                case .status410: return 410
                }
            }

            public var successful: Bool {
                switch self {
                case .status200: return true
                case .status400: return false
                case .status401: return false
                case .status404: return false
                case .status410: return false
                }
            }

            public init(statusCode: Int, data: Data) throws {
                switch statusCode {
                case 200: self = try .status200(JSONDecoder.decode(data: data))
                case 400: self = try .status400(JSONDecoder.decode(data: data))
                case 401: self = try .status401(JSONDecoder.decode(data: data))
                case 404: self = try .status404(JSONDecoder.decode(data: data))
                case 410: self = try .status410(JSONDecoder.decode(data: data))
                default: throw APIError.unexpectedStatusCode(statusCode: statusCode, data: data)
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
