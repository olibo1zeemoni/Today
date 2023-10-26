//
//  TextViewContentView.swift
//  Today
//
//  Created by Olibo moni on 25/10/2023.
//

import UIKit

class TextViewContentView: UIView, UIContentView {
    
    struct Configuration: UIContentConfiguration {
        var text: String? = ""
        var onChange: (String) -> Void = { _ in }

        func makeContentView() -> UIView & UIContentView {
            return TextViewContentView(self)
        }
        
    }
    
    let textView = UITextView()

    var configuration: UIContentConfiguration {
        didSet {
            configure(configuration: configuration)
        }
    }
    ///the system assigns an intrinsic content size to every subclass of UIView ––determined by what it displays
    override var intrinsicContentSize: CGSize {
        CGSize(width: 0, height: 44)
    }
    
    
    init(_ configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        addPinnedSubview(textView,height: 200)
        textView.backgroundColor = nil
        textView.delegate = self///setting textViewContentView to be the delegate of the textView. ie monitors textview control for user interaction.
        textView.font = UIFont.preferredFont(forTextStyle: .body)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(configuration: UIContentConfiguration) {
        guard let configuration = configuration as? Configuration else { return }
        textView.text = configuration.text
    }
}

extension UICollectionViewListCell {
    func textViewConfiguration() -> TextViewContentView.Configuration {
        TextViewContentView.Configuration()
    }
}


extension TextViewContentView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        guard let configuration = configuration as? TextViewContentView.Configuration else { return }
        configuration.onChange(textView.text)
    }
}
