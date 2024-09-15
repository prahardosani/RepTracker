import SwiftUI
import SwiftData

@main
struct RepTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            WorkoutListView()
        }
        .modelContainer(for: [Workout.self, Exercise.self, ExerciseSet.self])
    }
}

//#Preview {
//    ContentView()
//        .modelContainer(for: Item.self, inMemory: true)
//}
