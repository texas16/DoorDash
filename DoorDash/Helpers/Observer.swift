//
//  Box.swift
//  DoorDash
//
//  Created by ilyas on 12/10/18.
//  Copyright © 2018 ilyas. All rights reserved.
//

import Foundation

class Observer<T> {
    typealias Listener = (T) -> Void
    
    var listener: Listener?
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
