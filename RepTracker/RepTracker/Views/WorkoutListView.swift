import SwiftUI
import SwiftData

struct WorkoutListView: View {
    // Environment variable for the model context
    @Environment(\.modelContext) private var modelContext
    
    // Query to fetch all workouts
    @Query private var workouts: [Workout]
    
    // State variable to control the presentation of the AddWorkoutView
    @State private var showingAddWorkout = false
    
    var body: some View {
        NavigationView {
            List {
                // Display workouts sorted by date (most recent first)
                ForEach(workouts.sorted(by: { $0.date > $1.date })) { workout in
                    NavigationLink(destination: WorkoutDetailView(workout: workout)) {
                        VStack(alignment: .leading, spacing: 5) {
                            // Display workout date
                            Text(workout.date, style: .date)
                                .font(.headline)
                            // Display number of exercises in the workout
                            Text("\(workout.exercises.count) exercises")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .onDelete(perform: deleteWorkouts)
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Workouts")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    // Button to add a new workout
                    Button(action: { showingAddWorkout = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            // Present AddWorkoutView as a sheet when showingAddWorkout is true
            .sheet(isPresented: $showingAddWorkout) {
                AddWorkoutView()
            }
        }
    }
    
    // Function to delete workouts
    private func deleteWorkouts(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(workouts[index])
            }
        }
    }
}
