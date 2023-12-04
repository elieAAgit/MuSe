//
//  Category.swift
//  MuSe
//
//  Created by Elie Arquier on 13/04/2022.
//

import Foundation

// Custom category to be used in the Place entity for the category attribute of Transformable type
public class Category: NSObject, NSSecureCoding {

    public static var supportsSecureCoding: Bool = true
    
    let title: String
    let id: String

    public init(title: String,
         id: String) {
        self.title = title
        self.id = id
    }

    public required init?(coder: NSCoder) {
        // NSSecureCoding
        title = coder.decodeObject(of: NSString.self, forKey: "title") as String? ?? ""
        id = coder.decodeObject(of: NSString.self, forKey: "id") as String? ?? ""
    }

    public func encode(with coder: NSCoder) {
        coder.encode(title, forKey: "title")
        coder.encode(id, forKey: "id")
    }
}

// It has to be a subclass of `NSSecureUnarchiveFromDataTransformer` and need to expose it to ObjC.
@objc(CategoryValueTransformer)
final class CategoryValueTransformer: NSSecureUnarchiveFromDataTransformer {

    // The name of the transformer. This is what we will use to register the transformer `ValueTransformer.setValueTrandformer(_"forName:)`.
    static let name = NSValueTransformerName(rawValue: String(describing: CategoryValueTransformer.self))

    // Class should in the allowed class list. (This is what the unarchiver uses to check for the right class)
    override static var allowedTopLevelClasses: [AnyClass] {
        return [Category.self]
    }

    /// Registers the transformer.
    public static func register() {
        let transformer = CategoryValueTransformer()
        ValueTransformer.setValueTransformer(transformer, forName: name)
    }
}

struct Categories {
    static var categories: [Category] = [museum,
                                         theatre,
                                         garden,
                                         library]

    static let museum = Category(title: "Musée", id: "Museum")
    static let theatre = Category(title: "Cinéma", id: "Theatre")
    static let garden = Category(title: "Jardin", id: "Garden")
    static let library = Category(title: "Bibliothèque", id: "Library")
}
