import Foundation
import SwiftData

@Model
final class ExerciseSet {
    var reps: Int
    var weight: Double?
    
    init(reps: Int, weight: Double? = nil) {
        self.reps = reps
        self.weight = weight
    }
}
