//
//  ReusableProtocol.swift
//  Reminder
//
//  Created by Jinyoung Yoo on 7/2/24.
//

import UIKit

protocol ReusableProtocol {
    static var reusableIdentifier: String { get }
}

extension UICollectionViewCell: ReusableProtocol {
    static var reusableIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableProtocol {
    static var reusableIdentifier: String {
        return String(describing: self)
    }
}

