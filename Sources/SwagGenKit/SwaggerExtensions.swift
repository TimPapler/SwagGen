import Foundation
import Swagger
import Yams
import JSONUtilities
import PathKit

struct Enum {
    let name: String
    let cases: [Any]
    let isNonFrozen: Bool
    let type: EnumType
    let description: String?
    let metadata: Metadata

    enum EnumType {
        case schema(Schema)
        case item(Item)
    }
}

struct InlineObject {
    let name: String
    let description: String?
    let metadata: Metadata
    
    let schema: Schema
    
}

struct ResponseFormatter {
    let response: Response
    let successful: Bool
    let name: String?
    let statusCode: Int?
}

extension SwaggerSpec {

    var operationsByTag: [String: [Swagger.Operation]] {
        var dictionary: [String: [Swagger.Operation]] = [:]

        // add operations with no tag at ""
        let operationsWithoutTag = operations.filter { $0.tags.isEmpty }
        if !operationsWithoutTag.isEmpty {
            dictionary[""] = operationsWithoutTag
        }

        for tag in tags {
            dictionary[tag] = operations.filter { $0.tags.contains(tag) }
        }
        return dictionary
    }

    var enums: [Enum] {
        return parameters.flatMap { $0.value.getEnums(name: $0.name, description: $0.value.description) ?? [] }
    }
}

extension Metadata {

    func getEnum(name: String, type: Enum.EnumType, description: String?) -> Enum? {
        if let enumValues = enumeratedValues {
            return Enum(name: name, cases: enumValues.compactMap { $0 }, isNonFrozen: self.nonFrozenEnum == true, type: type, description: description ?? self.description, metadata: self)
        }
        return nil
    }
    
    func getInlineObject(name: String, description: String?, schema: Schema) -> InlineObject {
        return InlineObject(name: name, description: description ?? self.description, metadata: self, schema: schema)
    }
}

extension Schema {

    var parent: SwaggerObject<Schema>? {
        if case let .allOf(object) = type {
            for schema in object.subschemas {
                if case let .reference(reference) = schema.type {
                    return reference.swaggerObject
                }
            }
        }
        return nil
    }

    var properties: [Property] {
        return requiredProperties + optionalProperties
    }

    var requiredProperties: [Property] {
        switch type {
        case let .object(objectSchema): return objectSchema.requiredProperties
        case let .allOf(allOffSchema):
            for schema in allOffSchema.subschemas {
                if case let .object(objectSchema) = schema.type {
                    return objectSchema.requiredProperties
                }
            }
            return []
        default: return []
        }
    }

    var optionalProperties: [Property] {
        switch type {
        case let .object(objectSchema): return objectSchema.optionalProperties
        case let .allOf(allOffSchema):
            for schema in allOffSchema.subschemas {
                if case let .object(objectSchema) = schema.type {
                    return objectSchema.optionalProperties
                }
            }
        default: break
        }
        return []
    }

    var parentProperties: [Property] {
        return parentRequiredProperties + parentOptionalProperties
    }

    private var parentRequiredProperties: [Property] {
        return (parent?.value.parentRequiredProperties ?? []) + requiredProperties
    }

    private var parentOptionalProperties: [Property] {
        return (parent?.value.parentOptionalProperties ?? []) + optionalProperties
    }
    
    func getEnum(name: String, description: String?) -> Enum? {
        switch type {
        case let .object(objectSchema):
            if case let .schema(schema) = objectSchema.additionalProperties {
                return schema.getEnum(name: name, description: description)
            }
        case let .simple(simpleType):
            if simpleType.canBeEnum {
                return metadata.getEnum(name: name, type: .schema(self), description: description)
            }
        case let .array(array):
            if case let .single(schema) = array.items {
                return schema.getEnum(name: name, description: description)
            }
        default: break
        }
        return nil
    }
    
    func getInnerObject(name: String, description: String?) -> InlineObject? {
        switch type {
        case .object(let object) where !object.properties.isEmpty:
            return metadata.getInlineObject(name: name, description: description, schema: self)
        case let .array(array):
            if case let .single(schema) = array.items {
                return schema.getInnerObject(name: name, description: description)
            }
        default: break
        }
        return nil
    }

    var enums: [Enum] {
        var enums = properties.compactMap { property in
            property.schema.getEnum(name: property.name, description: property.schema.metadata.description)
        }
        
        if case let .object(objectSchema) = type, case let .schema(schema) = objectSchema.additionalProperties {
            enums += schema.enums
        } else if case let .array(arrayScehma) = type, case let .single(schema) = arrayScehma.items {
            enums += schema.enums
        }
        return enums
    }
    
    var inlinedObjects: [InlineObject] {
        return properties.compactMap { property in
            switch property.schema.type {
            case .object where nil == property.schema.getEnum(name: property.name, description: property.schema.metadata.description):
                return property.schema.getInnerObject(name: property.name, description: property.schema.metadata.description)
            case .array(let arraySchema):
                if case let .single(schema) = arraySchema.items {
                    return schema.getInnerObject(name: property.name, description: schema.metadata.description)
                }
                return nil
            default:
                return nil
            }
        }
        
    }
}

extension Swagger.Operation {

    func getParameters(type: ParameterLocation) -> [Parameter] {
        return parameters.map { $0.value }.filter { $0.location == type }
    }

    var enums: [Enum] {
        return requestEnums + responseEnums
    }

    var requestEnums: [Enum] {
        return parameters.flatMap { $0.value.enumValues ?? [] }
    }

    var responseEnums: [Enum] {
        return responses.compactMap { $0.enumValue }
    }

    var inlinedObjects: [InlineObject] {
        return self.bodyParam?.value.inlinedObjects ?? []
    }
}

extension ObjectSchema {

    var enums: [Enum] {
        var enums: [Enum] = []
        for property in properties {
            if let enumValue = property.schema.getEnum(name: property.name, description: property.schema.metadata.description) {
                enums.append(enumValue)
            }
        }
        if case let .schema(schema) = additionalProperties {
            if let enumValue = schema.getEnum(name: schema.metadata.title ?? "UNNKNOWN_ENUM", description: schema.metadata.description) {
                enums.append(enumValue)
            }
        }
        return enums
    }
}

extension OperationResponse {

    public var successful: Bool {
        return statusCode?.description.hasPrefix("2") ?? false
    }

    public var name: String {
        if let statusCode = statusCode {
            return "Status\(statusCode.description)"
        } else {
            return "DefaultResponse"
        }
    }

    var isEnum: Bool {
        return enumValue != nil
    }

    var enumValue: Enum? {
        return response.value.schema?.getEnum(name: name, description: response.value.description)
    }
}

extension Property {

    var isEnum: Bool {
        return enumValue != nil
    }

    var enumValue: Enum? {
        return schema.getEnum(name: name, description: schema.metadata.description)
    }
}

extension Parameter {

    var inlinedObjects: [InlineObject] {
        switch self.type {
        case .body(let schema):
            return [schema.getInnerObject(name: name, description: description)].compactMap({ $0 })
        case .other:
            return []
        }
    }

    func getEnums(name: String, description: String?) -> [Enum]? {
        switch type {
        case let .body(schema): return schema.enums
        case let .other(item): return item.getEnum(name: name, description: description).map({[$0]})
        }
    }

    var isEnum: Bool {
        return enumValues != nil
    }
    var isNonFrozenEnum: Bool {
        return enumValues?.first(where: { $0.isNonFrozen }) != nil
    }

    var enumValues: [Enum]? {
        return getEnums(name: name, description: description)
    }

    var isArray: Bool {
        switch type {
        case .body(let schema): return schema.type.isArray
        case .other(let item): return item.metadata.type == .array
        }
    }
}

extension SimpleType {

    var canBeEnum: Bool {
        switch self {
        case .string, .integer, .number:
            return true
        case .boolean, .file: return false
        }
    }
}

extension Item {

    func getEnum(name: String, description: String?) -> Enum? {

        switch type {
        case let .array(array):
            if case let .simpleType(simpleType) = array.items.type {
                if simpleType.canBeEnum, let enumValue = array.items.metadata.getEnum(name: name, type: .item(self), description: description) {
                    return enumValue
                }
            }
        case let .simpleType(simpleType):
            if simpleType.canBeEnum {
                return metadata.getEnum(name: name, type: .item(self), description: description)
            }
        }
        return nil
    }
}
