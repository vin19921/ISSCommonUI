//
//  File.swift
//  
//
//  Created by Wing Seng Chew on 13/07/2023.
//

import SwiftUI

public struct CustomTextField: UIViewRepresentable {
    var text: Binding<String>
    var isFirstResponder: Binding<Bool>

    var font: UIFont?
    var keyboardType: UIKeyboardType = .default
    var maxLength: Int?
    var toolbarButtonTitle: String
    var toolbarAction: ((ToolbarAction) -> Void)?
    var textFieldDidChange: () -> Void = {}

    public init(text: Binding<String>,
                isFirstResponder: Binding<Bool>,
                font: UIFont? = nil,
                keyboardType: UIKeyboardType = .default,
                toolbarButtonTitle: String = "",
                textFieldDidChange: @escaping () -> Void
    ) {
        // Initialize the properties
        self.text = text
        self.isFirstResponder = isFirstResponder
        self.font = font
        self.keyboardType = keyboardType
        self.toolbarButtonTitle = toolbarButtonTitle
        self.textFieldDidChange = textFieldDidChange
    }

    public func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        textField.font = font
        textField.keyboardType = keyboardType
        textField.delegate = context.coordinator
        addToolbar(textField)
        return textField
    }

    public func updateUIView(_ uiView: UITextField, context: Context) {
        if isFirstResponder.wrappedValue && !uiView.isFirstResponder {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                uiView.becomeFirstResponder()
            }
        } else if !isFirstResponder.wrappedValue && uiView.isFirstResponder {
            DispatchQueue.main.async {
                uiView.resignFirstResponder()
            }
        }
    }


    public func makeCoordinator() -> Coordinator {
        Coordinator(parent: self,
                    textFieldDidChange: {
                        self.textFieldDidChange()
                    })
    }
}

// MARK: - Coordinator

public extension CustomTextField {
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: CustomTextField
        var textFieldDidChange: () -> Void

        public init(parent: CustomTextField,
             textFieldDidChange: @escaping () -> Void)
        {
            self.parent = parent
            self.textFieldDidChange = textFieldDidChange
        }

        // Became first responder
        public func textFieldDidBeginEditing(_: UITextField) {
            parent.isFirstResponder.wrappedValue = true
        }

        public func textFieldDidChangeSelection(_ textField: UITextField) {
            parent.text.wrappedValue = textField.text ?? ""
            textFieldDidChange()
        }

        // Resign first responder
        public func textFieldDidEndEditing(_: UITextField) {
            parent.isFirstResponder.wrappedValue = false
        }

        public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            guard let maxLength = parent.maxLength else {
                return true
            }
            let currentString = (textField.text ?? "") as NSString
            let newString = currentString.replacingCharacters(in: range, with: string)
            return newString.count <= maxLength
        }
    }
}

// MARK: - Private

public extension CustomTextField {
    public func addToolbar(_ textField: UITextField) {
        let numberToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: Constant.toolbarHeight))
        numberToolbar.barStyle = .default
        numberToolbar.items = [UIBarButtonItem(image: UIImage(systemName: Constant.arrowUpImage),
                                               primaryAction: UIAction { _ in
                                                   toolbarAction?(.up)
                                               }),
                               UIBarButtonItem(image: UIImage(systemName: Constant.arrowDownImage),
                                               primaryAction: UIAction { _ in
                                                   toolbarAction?(.down)
                                               }),
                               UIBarButtonItem(systemItem: .flexibleSpace),
                               UIBarButtonItem(title: toolbarButtonTitle,
                                               primaryAction: UIAction { _ in
                                                   textField.resignFirstResponder()
                                                   toolbarAction?(.done)
                                               })]
        numberToolbar.sizeToFit()
        textField.inputAccessoryView = numberToolbar
    }
}

// MARK: - Nested type

public extension CustomTextField {
    public enum Constant {
        static let toolbarHeight: CGFloat = 50
        static let arrowUpImage = "chevron.up"
        static let arrowDownImage = "chevron.down"
    }
}

public enum ToolbarAction {
    case done, up, down
}

