//
//  TextStyles.swift
//  RavnChallengeV2
//
//  Created by Manuel Sánchez on 11/11/20.
//

import SwiftUI

struct HeadingStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 17, weight: .bold))
            .foregroundColor(.textDark)
    }
}

struct HeadingHighEmphasisStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 17, weight: .bold))
            .foregroundColor(.textEmphasis)
    }
}

struct HeadingLowEmphasisStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 17, weight: .bold))
            .foregroundColor(.textLight)
    }
}

struct ParagraphStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 14, weight: .regular))
            .foregroundColor(.textDark)
    }
}

struct ParagraphLowEmphasisStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 14, weight: .regular))
            .foregroundColor(.textLight)
    }
}

extension Text {
    func textStyle<Style: ViewModifier>(_ style: Style) -> some View {
        ModifiedContent(content: self, modifier: style)
    }
}
