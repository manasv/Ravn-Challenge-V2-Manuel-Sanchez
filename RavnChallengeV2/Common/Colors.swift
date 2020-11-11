//
//  Colors.swift
//  RavnChallengeV2
//
//  Created by Manuel Sánchez on 11/11/20.
//

import SwiftUI

enum ColorName {
    static let ravnBlack = "ravnBlack"
    static let textDark = "textDark"
    static let textLight = "textLight"
    static let textEmphasis = "textEmphasis"
}

extension Color {
    static let ravnBlack = Color(ColorName.ravnBlack)
    static let textDark = Color(ColorName.textDark)
    static let textLight = Color(ColorName.textLight)
    static let textEmphasis = Color(ColorName.textEmphasis)
}
