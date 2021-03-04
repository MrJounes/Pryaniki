//
//  ListDataResponse.swift
//  PryanikyTest
//
//  Created by Игорь Дикань on 04.03.2021.
//

struct ListDataResponse: Decodable {
    let data: [InormationItem]
    let view: [String]
}

struct InormationItem: Decodable {
    let name: String
    let data: DataItem
}

struct DataItem: Decodable {
    let text: String?
    let url: String?
    let selectedId: Int?
    let variants: [Variant]?
}

struct Variant: Decodable {
    let id: Int
    let text: String
}
