//
//  ObservableType+Helper.swift
//  ParkingSpaces
//
//  Created by Matej Hacin on 20/09/2017.
//  Copyright © 2017 Matej Hacin. All rights reserved.
//

import Foundation
import RxSwift

extension ObservableType {
    
    func convertToModel<T:JSONInitializable>() -> Observable<T> {
        let value = asObservable()
        return Observable.create { observer in
            let subscription = value.subscribe { event in
                switch event {
                case .next(let element):
                    if let dict = element as? NSDictionary {
                        observer.on(.next(T(from: dict)))
                    }
                    else if let array = element as? NSArray {
                        for item in array {
                            observer.on(.next(T(from: item as! NSDictionary)))
                        }
                    }
                    break
                case .error(let error):
                    observer.on(.error(error))
                    break
                case .completed:
                    observer.on(.completed)
                    break
                }
            }
            return subscription
        }
    }
    
}
