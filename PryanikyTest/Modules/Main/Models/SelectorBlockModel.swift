//
//  SelectorBlockModel.swift
//  PryanikyTest
//
//  Created by Игорь Дикань on 04.03.2021.
//

struct SelectorBlockModel: DataModelProtocol {
    let name: String
    let selectedId: Int
    let variants: [VariantModel]
}

struct VariantModel {
    let id: Int
    let text: String
}
