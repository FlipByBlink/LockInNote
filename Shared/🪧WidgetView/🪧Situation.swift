import SwiftUI

enum 🪧Situation {
    case placeholder, snapshot, timeline, previewInApp
}

extension EnvironmentValues {
    var ⓢituation: 🪧Situation {
        get { self[Self.🪧SituationKey.self] }
        set { self[Self.🪧SituationKey.self] = newValue }
    }
    private struct 🪧SituationKey: EnvironmentKey {
        static let defaultValue: 🪧Situation = .timeline
    }
}
