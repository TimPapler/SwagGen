import JSONUtilities

public struct Schema {
    public let metadata: Metadata
    public let type: SchemaType
}

public enum SchemaType {
    indirect case reference(Reference<Schema>)
    indirect case object(ObjectSchema)
    indirect case array(ArraySchema)
    indirect case allOf(AllOfSchema)
    case simple(SimpleType)
    case any
}

extension SchemaType {
    
    public var isArray: Bool {
        switch self {
        case .array:
            return true
        default:
            return false
        }
    }
}
extension Schema: JSONObjectConvertible {

    public init(jsonDictionary: JSONDictionary) throws {
        metadata = try Metadata(jsonDictionary: jsonDictionary)
        type = try SchemaType(jsonDictionary: jsonDictionary)
    }
}

extension SchemaType: JSONObjectConvertible {

    public init(jsonDictionary: JSONDictionary) throws {
        if let simpleType = SimpleType(jsonDictionary: jsonDictionary) {
            self = .simple(simpleType)
        } else if let dataType = DataType(jsonDictionary: jsonDictionary) {
            switch dataType {
            case .array:
                self = .array(try ArraySchema(jsonDictionary: jsonDictionary))
            case .object:
                self = .object(try ObjectSchema(jsonDictionary: jsonDictionary))
            default:
                throw SwaggerError.incorrectSchemaType(jsonDictionary)
            }
        } else if jsonDictionary["$ref"] != nil {
            self = .reference(try Reference(jsonDictionary: jsonDictionary))
        } else if jsonDictionary["allOf"] != nil {
            self = .allOf(try AllOfSchema(jsonDictionary: jsonDictionary))
        } else {
            self = .any
        }
    }
}

extension Schema {
    
    public var parameterizedType: String? {
        switch type {
        case .array(let arraySchema):
            
            if let parameterizedType = arraySchema.parameterizedType {
                return "[" + parameterizedType + "]"
            }
            fallthrough
        default:
            return metadata.parameterizedType
        }
    }
}
