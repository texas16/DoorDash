//
//  Networking.swift
//  DoorDash
//
//  Created by ilyas on 12/10/18.
//  Copyright © 2018 ilyas. All rights reserved.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case emptyResponse
}

enum Result<T> {
    case success(T)
    case failure(Error)
}

