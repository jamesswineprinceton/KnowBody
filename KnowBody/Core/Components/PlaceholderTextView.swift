//
//  PlaceholderTextView.swift
//  KnowBody
//
//  Created by James Swinehart on 8/8/25.
//
import SwiftUI
import UIKit

public struct PlaceholderTextView: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String
    var isFocused: FocusState<Bool>.Binding

    public func makeCoordinator() -> Coordinator { Coordinator(self) }

    public func makeUIView(context: Context) -> UITextView {
        let tv = UITextView()
        tv.font = UIFont.preferredFont(forTextStyle: .footnote)
        tv.isScrollEnabled = true
        tv.backgroundColor = .clear
        tv.delegate = context.coordinator
        tv.textContainerInset = UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 0)
        tv.textContainer.lineFragmentPadding = 0
        tv.contentInset = .zero

        // Non-editable placeholder label overlay
        let ph = UILabel()
        ph.text = placeholder
        ph.font = tv.font
        ph.textColor = .placeholderText
        ph.numberOfLines = 0
        ph.translatesAutoresizingMaskIntoConstraints = false
        tv.addSubview(ph)
        NSLayoutConstraint.activate([
            ph.leadingAnchor.constraint(equalTo: tv.leadingAnchor, constant: tv.textContainerInset.left + tv.textContainer.lineFragmentPadding),
            ph.trailingAnchor.constraint(lessThanOrEqualTo: tv.trailingAnchor, constant: -(tv.textContainerInset.right + tv.textContainer.lineFragmentPadding)),
            ph.topAnchor.constraint(equalTo: tv.topAnchor, constant: tv.textContainerInset.top)
        ])
        context.coordinator.placeholderLabel = ph
        ph.isHidden = !text.isEmpty || isFocused.wrappedValue

        return tv
    }

    public func updateUIView(_ uiView: UITextView, context: Context) {
        // Keep UIKit view in sync with model without ever injecting placeholder text
        if uiView.text != text { uiView.text = text }
        context.coordinator.placeholderLabel?.isHidden = !text.isEmpty || isFocused.wrappedValue
    }

    public class Coordinator: NSObject, UITextViewDelegate {
        var parent: PlaceholderTextView
        weak var placeholderLabel: UILabel?

        init(_ parent: PlaceholderTextView) { self.parent = parent }

        public func textViewDidBeginEditing(_ textView: UITextView) {
            parent.isFocused.wrappedValue = true
            placeholderLabel?.isHidden = true
        }
        public func textViewDidEndEditing(_ textView: UITextView) {
            parent.isFocused.wrappedValue = false
            placeholderLabel?.isHidden = !textView.text.isEmpty
        }
        public func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
            placeholderLabel?.isHidden = !textView.text.isEmpty
        }
    }
}

