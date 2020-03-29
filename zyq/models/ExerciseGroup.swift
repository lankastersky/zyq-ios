import Foundation

class ExerciseGroup {
    var name: String
    var type: Int
    var level: Int

    init(
        _ name: String,
        _ type: Int,
        _ level: Int
    ) {
        self.name = name
        self.type = type
        self.level = level
    }
}
