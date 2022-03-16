//
//  Interpreter.swift
//  PlanEditor
//
//  Created by Nikita Semenov on 11.03.2022.
//

import SwiftUI

enum InterpreterError: Error {
    case wrongSyntaxOfObjects
    case wrongSyntaxOfUpdatingKeyword
    case wrongSyntaxOfTillKeyword
    case wrongSyntaxOfProperty
}

final class Interpreter: ObservableObject {
    @Published var content: Binding<String>
    @Published var objects: [Object] = []
    @Published var error: Error? = nil
    
    init(_ doc: Binding<PlanEditorDocument>) {
        content = doc.content
    }
    
    @discardableResult
    func interprete() -> [Object] {
        let results = findObjects(content.wrappedValue)
        let stringObjects = unwrapResults(results)
        guard !stringObjects.isEmpty else { return Array<Object>.empty }
        
        let objects = createObjects(stringObjects)
        self.objects = objects
        
        return objects
    }
    
    func unwrapResults<Content: EmptyContent, E: Error>(_ results: Result<Content, E>) -> Content {
        switch results {
            case let .success(content):
                self.error = nil
                return content
            case let .failure(error):
                self.error = error
        }
        
        return Content.empty
    }
    
    private func findObjects(_ wrappedValue: String) -> Result<[String], InterpreterError> {
        let lines = wrappedValue.appending("\n").split(separator: "\n")
        var objects: [String] = []
        var currentObject: Stack<String> = Stack(lookingForChar: "@", amount: 2)
        
        for line in lines {
            let stringLine = String(line)
            if !stringLine.isComment {
                currentObject.push(stringLine)
            }
            
            if currentObject.isFound {
                objects.append(
                    currentObject.getOrigin()
                        .joined(separator: "\n")
                )
            }
        }
        
        guard currentObject.isEmpty else {
            return .failure(.wrongSyntaxOfObjects)
        }
        
        return .success(objects)
    }
    
    private func createObjects(_ stringObjects: [String]) -> [Object] {
        var objects: [Object] = []
        for stringObject in stringObjects {
            let result = createObject(stringObject)
            let object = unwrapResults(result)
            objects.append(object)
        }
        return objects
    }
    
    private func createObject(_ stringObject: String) -> Result<Object, InterpreterError> {
        var stringObject = stringObject.split(separator: "\n")
        var newObject = Object.empty
        stringObject.removeLast()
        
        for line in stringObject {
            let stringLine = String(line)
            
            if stringLine.isObject {
                newObject.name = stringLine.getObjectName()
            } else if let keyword = stringLine.isKeyword {
                switch keyword {
                    case .list:
                        fallthrough
                    case .table:
                        newObject.type = keyword
                    case .updating(_):
                        if let keywordDate = stringLine.getUpdatingDate() {
                            newObject.keywords.append(.updating(every: keywordDate))
                        } else {
                            return .failure(.wrongSyntaxOfUpdatingKeyword)
                        }
                    case .till(_):
                        if let date = stringLine.getTillDate() {
                            newObject.keywords.append(.till(date))
                        } else {
                            return .failure(.wrongSyntaxOfTillKeyword)
                        }
                    default:
                        newObject.keywords.append(keyword)
                }
            } else if stringLine.isProperty {
                if let newProperty = createProperty(from: stringLine) {
                    newObject.properties.append(newProperty)
                } else {
                    return .failure(.wrongSyntaxOfProperty)
                }
            } else {
                var lastProperty = newObject.properties.popLast()!
                lastProperty.value += stringLine
                newObject.properties.append(lastProperty)
            }
        }
        return .success(newObject)
    }
    
    private func createProperty(from stringLine: String) -> Property? {
        var newProperty = Property.empty
        let propertyName = stringLine.getPropertyName()
        let propertyValue = stringLine.getPropertyValue()
        
        newProperty.name = propertyName
        
        if let propertyValue = propertyValue {
            newProperty.value = propertyValue
            return newProperty
        }
        
        return nil
    }
}
