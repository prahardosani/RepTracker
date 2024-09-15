import Foundation
import SwiftData

@Model
final class Exercise {
    var name: String
    var sets: [ExerciseSet]
    
    init(name: String, sets: [ExerciseSet] = []) {
        self.name = name
        self.sets = sets
    }
}
