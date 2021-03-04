//
//  DataService.swift
//  PryanikyTest
//
//  Created by Игорь Дикань on 04.03.2021.
//

final class DataService {
    
    private let service: NetworkServiceable
    
    init(service: NetworkServiceable) {
        self.service = service
    }
}

// MARK: - Public methods
extension DataService {
    
    func fetchListData(_ request: ListDataRequest, complition: @escaping (Result<ListDataResponse, Error>) -> Void) {
        service.request(.listData(request: request), completion: complition)
    }
}
