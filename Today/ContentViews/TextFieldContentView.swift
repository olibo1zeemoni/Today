//
//  TextFieldContentView.swift
//  Today
//
//  Created by Olibo moni on 25/10/2023.
//

import UIKit

class TextFieldContentView: UIView, UIContentView {
    
    struct Configuration: UIContentConfiguration {
        var text: String? = ""
        var onChange: (String) -> Void = { _ in }

        func makeContentView() -> UIView & UIContentView {
            return TextFieldContentView(self)
        }
        
    }
    
    var configuration: UIContentConfiguration {
        didSet {
            configure(configuration: configuration)
        }
    }
    let textField = UITextField()
    
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: 0, height: 44) //min size for an accessible control is 44 apple HI guidelines
    }
    
    init(_ configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        addPinnedSubview(textField, insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
        textField.clearButtonMode = .whileEditing
        
        textField.addTarget(self, action: #selector(didChange(_:)), for: .editingChanged)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(configuration: UIContentConfiguration) {
        guard let configuration = configuration as? Configuration else { return }
        textField.text = configuration.text
    }
    
    @objc private func didChange(_ sender: UITextField) {
        guard let configuration = configuration as? TextFieldContentView.Configuration else { return }
        configuration.onChange(sender.text ?? "")
        
        }
    
}


extension UICollectionViewListCell {
    func textFieldConfiguration() -> TextFieldContentView.Configuration {
        TextFieldContentView.Configuration()
    }
}
