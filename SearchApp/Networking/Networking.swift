//
//  NetworkProvider.swift
//  SearchApp
//
//  Created by Vural Γelik on 26.06.2021.
//

import Alamofire
import RxSwift

class Networking {
    static func request<T: Decodable>(router: RouterProvider,
                                      thread: DispatchQoS.QoSClass? = nil,
                                      shouldShowLoading: Bool = true) -> Observable<T> {
        return Observable<T>.create { (observer) -> Disposable in
            let request = AF.request(router).validate(statusCode: 200..<300).responseDecodable { (response: AFDataResponse<T>) in
                printLog(response: response)
                switch response.result {
                case .success(let baseData):
                    observer.onNext(baseData)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }

    static private func printLog<T: Decodable>(response: AFDataResponse<T>) {
        print("\n\n\n")
        print("πππππππππππππππππππππ")
        debugPrint(response)
        print("πππππππππππππππππππππ")
        print("\n\n\n")
    }
}
