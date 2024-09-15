import SwiftUI

struct WorkoutDetailView: View {
    // The workout to display
    let workout: Workout
    
    // Date formatter for the navigation title
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
    
    var body: some View {
        List {
            // Iterate through each exercise in the workout
            ForEach(workout.exercises) { exercise in
                // Create a section for each exercise
                Section(header: Text(exercise.name).font(.headline)) {
                    // Display each set in the exercise
                    ForEach(exercise.sets) { set in
                        HStack {
                            // Display the number of reps
                            Text("\(set.reps) reps")
                            Spacer()
                            // Display the weight if it exists
                            if let weight = set.weight {
                                Text("\(weight, specifier: "%.1f") kg")
                            }
                        }
                    }
                }
            }
        }
        // Set the navigation title to the formatted workout date
        .navigationTitle(dateFormatter.string(from: workout.date))
        // Use the inset grouped list style for a modern look
        .listStyle(InsetGroupedListStyle())
    }
}
