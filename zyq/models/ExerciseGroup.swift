import Foundation

class ExerciseGroup {
    var name: String
    var type: ExerciseType
    var level: LevelType

    init(
        _ name: String,
        _ type: ExerciseType,
        _ level: LevelType
    ) {
        self.name = name
        self.type = type
        self.level = level
    }
}
