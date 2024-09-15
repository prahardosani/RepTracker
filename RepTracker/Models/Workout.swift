import Foundation
import SwiftData

@Model
final class Workout {
    var date: Date
    var exercises: [Exercise]
    
    init(date: Date = Date(), exercises: [Exercise] = []) {
        self.date = date
        self.exercises = exercises
    }
}
