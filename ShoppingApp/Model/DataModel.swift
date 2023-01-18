//
//  DataModel.swift
//  ShoppingApp
//
//  Created by Aniket Patil on 17/01/23.
//

import Foundation

// MARK: - DataModel
struct DataModel: Codable {
    var status: Int?
    var message: String?
    var data: Data?
}

// MARK: - Data
struct Data: Codable {
    var id, sku, name, attributeSetID: String?
    var price, finalPrice, status, type: String?
    var brand: String?
    var image: String?
    var createdAt, updatedAt, weight: String?
    var isSalable: Bool?
    var description: String?
    var howToUse: String?
    var metaTitle, metaKeyword, metaDescription: String?
    var wishlistItemID: Int?
    var hasOptions: String?
    var configurableOption: [ConfigurableOption]?
    var remainingQty: Int?
    var images: [String]?

    enum CodingKeys: String, CodingKey {
        case id, sku, name
        case attributeSetID = "attribute_set_id"
        case price
        case finalPrice = "final_price"
        case status, type, brand, image
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case weight
        case isSalable = "is_salable"
        case description
        case howToUse = "how_to_use"
        case metaTitle = "meta_title"
        case metaKeyword = "meta_keyword"
        case metaDescription = "meta_description"
        case wishlistItemID = "wishlist_item_id"
        case hasOptions = "has_options"
        case configurableOption = "configurable_option"
        case remainingQty = "remaining_qty"
        case images
    }
}

// MARK: - ConfigurableOption
struct ConfigurableOption: Codable {
    var attributeID: Int?
    var attributeLabel, type, attributeCode: String?
    var attributes: [Attribute]?

    enum CodingKeys: String, CodingKey {
        case attributeID = "attribute_id"
        case attributeLabel = "attribute_label"
        case type
        case attributeCode = "attribute_code"
        case attributes
    }
}

// MARK: - Attribute
struct Attribute: Codable {
    var value, optionID, attributeImageURL, hexCode: String?
    var price: String?
    var images: [String]?

    enum CodingKeys: String, CodingKey {
        case value
        case optionID = "option_id"
        case attributeImageURL = "attribute_image_url"
        case hexCode = "hex_code"
        case price, images
    }
}
