//
//  KIVListCellInterface.swift
//  AddressService
//
//  Created by kvian on 05/05/2018.
//  Copyright © 2018 Kivan. All rights reserved.
//

import UIKit

public protocol KivListBaseCellProtocol {
    var identifier:NSString {get}
    func updateCell(data:KivBaseItem) -> Void
    static func cellHeight(data:KivBaseItem) -> CGFloat
}

public extension KivListBaseCellProtocol{
    static func cellHeight(data:KivBaseItem) -> CGFloat{
        return 0.0
    }
    static func cellWidth(data:KivBaseItem)->CGFloat{
        return 0.0
    }
}
