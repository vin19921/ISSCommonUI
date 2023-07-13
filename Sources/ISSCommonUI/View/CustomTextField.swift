//
//  File.swift
//  
//
//  Created by Wing Seng Chew on 13/07/2023.
//

import SwiftUI

public struct CustomTextField: UIViewRepresentable {
    @Binding public var text: String
//    public var text: Binding<String>
//    public var isFirstResponder: Binding<Bool>

    @Binding var isFirstResponder: Bool

    public var font: UIFont?
    public var keyboardType: UIKeyboardType = .default
    public var maxLength: Int?
    public var toolbarButtonTitle: String
    public var toolbarAction: ((ToolbarAction) -> Void)?
    public var textFieldDidChange: () -> Void

    public func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        textField.font = font
        textField.keyboardType = keyboardType
        textField.delegate = context.coordinator
        addToolbar(textField)
        return textField
    }

    public func updateUIView(_ uiView: UITextField, context _: Context) {
        guard isFirstResponder, !uiView.isFirstResponder else {
            return
        }
        uiView.becomeFirstResponder()
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
        let parent: CustomTextField
        var textFieldDidChange: () -> Void

        public init(parent: CustomTextField,
             textFieldDidChange: @escaping () -> Void)
        {
            self.parent = parent
            self.textFieldDidChange = textFieldDidChange
        }

        // Became first responder
        public func textFieldDidBeginEditing(_: UITextField) {
            parent.isFirstResponder = true
        }

        public func textFieldDidChangeSelection(_ textField: UITextField) {
            parent.text = textField.text ?? ""
            textFieldDidChange()
        }

        // Resign first responder
        public func textFieldDidEndEditing(_: UITextField) {
            parent.isFirstResponder = false
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

private extension CustomTextField {
    func addToolbar(_ textField: UITextField) {
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

private extension CustomTextField {
    enum Constant {
        static let toolbarHeight: CGFloat = 50
        static let arrowUpImage = "chevron.up"
        static let arrowDownImage = "chevron.down"
    }
}

public enum ToolbarAction {
    case done, up, down
}

