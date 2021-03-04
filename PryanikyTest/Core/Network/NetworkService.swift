//
//  NetworkService.swift
//  PryanikyTest
//
//  Created by Игорь Дикань on 04.03.2021.
//

import Foundation
import Moya
import Alamofire

enum ApiError: Swift.Error {
    case networkError(errorMessage: String)
    case parserError
    case invalidData
    case internalError
    case userNotAuthorized
    case unknown
    case generalError(errorMessage: String, statusCode: StatusCode)

    var userString: String {
        switch self {
        default:
            return ""
        }
    }
}

struct ApiErrorModel: Codable {
    let message: String
}

protocol NetworkServiceable {
    func request<T: Decodable>(_ endPoint: APIEndPoint, completion: @escaping (Result<T, Error>) -> Void)
}

typealias StatusCode = Int

final class NetworkService {
    
    let defaults: UserDefaults
    
    private let provider = MoyaProvider<TargetProvider>(endpointClosure: NetworkService.endpointClosure, session: DefaultAlamofireManager.sharedManager)
    
    init() {
        defaults = .standard
    }
    
}

extension NetworkService: NetworkServiceable {
    
    private static func customEndpointMapping(for target: TargetProvider) -> Endpoint {
        let url = "\(target.baseURL.absoluteString)\(target.path)"

        //print("Url: - \(url) \n method: - \(target.method) \n task: - \(target.task) \n headers: - \(target.headers)")
        
        return Endpoint(url: url,
                        sampleResponseClosure: { .networkResponse(200, target.sampleData) },
                        method: target.method,
                        task: target.task,
                        httpHeaderFields: target.headers)
    }

    static let endpointClosure = { (target: TargetProvider) -> Endpoint  in
        let defaultEndpoint = customEndpointMapping(for: target)
        return defaultEndpoint
    }

    func request<T: Decodable>(
        _ endPoint: APIEndPoint,
        completion: @escaping (Result<T, Error>) -> Void ) {
        
        let targetProvider = TargetProvider(with: endPoint)
        provider.request(targetProvider, completion: { (result) in
            switch result {
            case let .success(response):
                switch response.statusCode {
                case 200...210:
//                    if let result: T = EmptyResponse() as? T {
//                        completion(.success(result))
//                        return
//                    }
                    
                    do {
                        let result: T = try response.data.decode()
                        completion(.success(result))
                    } catch {
                        completion(.failure(ApiError.invalidData))
                    }

                default:
                    self.handlerErrorResponse(
                        endPoint,
                        data: response,
                        completion: completion)
                }
            case .failure:
                completion(.failure(ApiError.internalError))
            }
        })
    }
}

private extension NetworkService {
    func handlerErrorResponse<T: Decodable>(
        _ endPoint: APIEndPoint,
        data: Response,
        completion: @escaping (Result<T, Error>) -> Void ) {

        switch data.statusCode {
            case 401:
//                refreshToken { (result) in
//                    switch result {
//                    case .success:
//                        self.request(
//                            endPoint,
//                            completion: completion
//                        )
//                    case .failure(let error):
//                        completion(.failure(error))
//                    }
//                }
                completion(.failure(ApiError.userNotAuthorized))
            case 403:
                completion(.failure(ApiError.userNotAuthorized))
            case 409:
                completion(.failure(ApiError.generalError(errorMessage: "", statusCode: 409)))
            default:
                completion(.failure(ApiError.unknown))
        }
        
    }
    
//    func refreshToken(completion: @escaping (Result<Moya.Response, Error>) -> Void) {
//        guard
//            let refreshToken = tipKeychain.refreshToken
//        else {
//                completion(.failure(ApiError.userNotAuthorized))
//                return
//        }
//        let request = RefreshTokenRequest(refreshToken: refreshToken)
//        let targetProvider = TargetProvider(with: .authRefreshToken(request))
//
//        provider.request(targetProvider) { result in
//
//            switch result {
//            case .success(let response):
//
//                switch response.statusCode {
//                case 403, 401, 400:
//
//                    self.sendTokens(nil)
//
//                    completion(.failure(ApiError.userNotAuthorized))
//                    return
//
//                default:
//                    break
//                }
//
//                do {
//                    let tokenResponse: RefreshTokenResponse = try response.data.decode()
//                    self.sendTokens(tokenResponse)
//                    completion(.success(response))
//                } catch {
//                    completion(.failure(ApiError.userNotAuthorized))
//                }
//
//            case .failure:
//                self.sendTokens(nil)
//                completion(.failure(ApiError.userNotAuthorized))
//            }
//        }
//    }
    
//    func sendTokens(_ tokens: RefreshTokenResponse?) {
//        defaults.isLoggedIn = tokens == nil ? false : true
//        tipKeychain.accessToken = tokens?.accessToken
//        tipKeychain.refreshToken = tokens?.refreshToken
//
//        if tokens == nil {
//            guard let vc = R.storyboard.login().instantiateInitialViewController() else {
//                return
//            }
//            vc.setupEmptyBackButton()
//            AppDelegate.setRootViewController(vc, isNavigationBarHidden: false)
//        }
//    }
}

extension Data {
    func decode<T: Decodable>(type: T.Type = T.self) throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let decoded = try decoder.decode(type, from: self)
            return decoded
        } catch {
            print("❗DECODING ERROR❗: \(error)")
            throw error
        }
    }
}

class DefaultAlamofireManager: Alamofire.Session {
    static let sharedManager: DefaultAlamofireManager = {
        let configuration = URLSessionConfiguration.default
        configuration.headers = .default
        configuration.requestCachePolicy = .useProtocolCachePolicy
        return DefaultAlamofireManager(configuration: configuration)
    }()
}
