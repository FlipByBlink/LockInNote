import SwiftUI
import WidgetKit
import WatchConnectivity

class 📱AppModel: NSObject, ObservableObject {
    @Published var rectangularModel: 🎛RectangularWidgetModel = .load() ?? .default
    @Published var circularModel: 🎛CircularWidgetModel = .load() ?? .default
    @Published var inlineModel: 🎛InlineWidgetModel = .load() ?? .default
    
    func saveDataAndReloadWidget() {
        self.rectangularModel.save()
        self.circularModel.save()
        self.inlineModel.save()
        WidgetCenter.shared.reloadAllTimelines()
    }
}

//extension 📱AppModel: WKApplicationDelegate {
//
//}
//
//extension 📱AppModel: WCSessionDelegate {
//
//}
