import SwiftUI
import SwiftData

struct AddWorkoutView: View {
    // Environment variables
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    // State variables
    @State private var workoutDate = Date()
    @State private var exercises: [ExerciseInput] = [ExerciseInput()]
    
    var body: some View {
        NavigationView {
            Form {
                // Date picker section
                Section(header: Text("Workout Date")) {
                    DatePicker("Date", selection: $workoutDate, displayedComponents: .date)
                }
                
                // Exercises section
                Section(header: Text("Exercises")) {
                    // Display input fields for each exercise
                    ForEach($exercises) { $exercise in
                        ExerciseInputView(exercise: $exercise)
                    }
                    
                    // Button to add a new exercise
                    Button(action: {
                        exercises.append(ExerciseInput())
                    }) {
                        Label("Add Exercise", systemImage: "plus.circle")
                    }
                }
                
                // Save button section
                Section {
                    Button("Save Workout") {
                        saveWorkout()
                    }
                }
            }
            .navigationTitle("Add Workout")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
    
    // Function to save the workout
    private func saveWorkout() {
        let workout = Workout(date: workoutDate)
        
        for exerciseInput in exercises {
            let exercise = Exercise(name: exerciseInput.name)
            for setInput in exerciseInput.sets {
                // Convert reps to Int and ensure it's positive
                if let reps = Int(setInput.reps), reps > 0 {
                    let set = ExerciseSet(reps: reps, weight: Double(setInput.weight))
                    exercise.sets.append(set)
                }
            }
            // Only add exercises with at least one valid set
            if !exercise.sets.isEmpty {
                workout.exercises.append(exercise)
            }
        }
        
        // Only save workouts with at least one exercise
        if !workout.exercises.isEmpty {
            modelContext.insert(workout)
            dismiss()
        }
    }
}

// Struct to hold input data for an exercise
struct ExerciseInput: Identifiable {
    let id = UUID()
    var name: String = ""
    var sets: [SetInput] = [SetInput()]
}

// Struct to hold input data for a set
struct SetInput: Identifiable {
    let id = UUID()
    var reps: String = ""
    var weight: String = ""
}

// View for inputting exercise details
struct ExerciseInputView: View {
    @Binding var exercise: ExerciseInput
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Exercise name input
            TextField("Exercise Name", text: $exercise.name)
                .font(.headline)
            
            // Set inputs
            ForEach($exercise.sets) { $set in
                HStack {
                    // Reps input
                    TextField("Reps", text: $set.reps)
                        .keyboardType(.numberPad)
                        .frame(width: 60)
                    // Weight input
                    TextField("Weight", text: $set.weight)
                        .keyboardType(.decimalPad)
                        .frame(width: 80)
                    
                    Spacer()
                    
                    // Button to add a new set
                    Button(action: {
                        exercise.sets.append(SetInput())
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.blue)
                    }
                }
            }
        }
        .padding(.vertical, 5)
    }
}
