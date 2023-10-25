//
//  UIContentConfiguration+Stateless.swift
//  Today
//
//  Created by Olibo moni on 25/10/2023.
//

import UIKit

extension UIContentConfiguration {
    ///allows a UIContentConfiguration to provide a specialized configuration for a given state
    func updated(for state: UIConfigurationState) -> Self {
        return self
    }
}
