import Foundation
import SwiftyJSON

final class ExerciseService {

    private var exercisesMap: [String: Exercise] = [:]
    private let jsonDecoder: JSONDecoder

    init(_ jsonDecoder: JSONDecoder) {
        self.jsonDecoder = jsonDecoder
    }

    convenience init() {
        self.init(JSONDecoder())
    }

    func load() {
        exercisesMap.removeAll()
        guard let preferredLanguage = Locale.preferredLanguages.first else {
            assertionFailure("Failed to get locale")
            return
        }
        if preferredLanguage.starts(with: "ru-") {
            loadExercises(from: "exercises1.json", to: &exercisesMap)
            loadExercises(from: "exercises2.json", to: &exercisesMap)
            loadExercises(from: "exercises3.json", to: &exercisesMap)
        } else {
            loadExercises(from: "exercises1_en.json", to: &exercisesMap)
            loadExercises(from: "exercises2_en.json", to: &exercisesMap)
            loadExercises(from: "exercises3_en.json", to: &exercisesMap)
        }
    }

    public func buildExerciseGroups(level: LevelType) -> [ExerciseGroup] {
        var groups = [ExerciseGroup]()
        groups.append(ExerciseGroup(
            ExerciseType.warmup.description, ExerciseType.warmup, level))
        groups.append(ExerciseGroup(
            ExerciseType.main.description, ExerciseType.main, level))
        groups.append(ExerciseGroup(
            ExerciseType.supporting.description, ExerciseType.supporting, level))
        // TODO: check if we have them
        groups.append(ExerciseGroup(
            ExerciseType.closing.description, ExerciseType.closing, level))
        // TODO: check if we have them
        groups.append(ExerciseGroup(
            ExerciseType.treatment.description, ExerciseType.treatment, level))
        return groups
    }

    public func getExercises(level: LevelType, type: ExerciseType) -> [Exercise] {
        var exercises = [Exercise]()
        for (_, ex) in exercisesMap {
            if (type != .unknown) {
                if (ex.type != type) {
                    continue
                }
            }
            if (ex.level != level) {
                continue
            }
            exercises.append(ex)
        }
        return exercises
    }

    public func getPracticeDescription(level: LevelType) -> URL? {
        guard let resourcePath = Bundle.main.resourcePath else {
            assertionFailure("failed to get bundle path")
            return nil
        }
        let fileName = String(format: "ex_%d.html", level.rawValue)
        let path = URL(fileURLWithPath:resourcePath).appendingPathComponent("assets/" + fileName)
            .path
        return URL(fileURLWithPath: path)
    }

    private func loadExercises(from fileName: String, to map: inout [String: Exercise]) {
        guard let resourcePath = Bundle.main.resourcePath else {
            assertionFailure("failed to get bundle path")
            return
        }
        let path = URL(fileURLWithPath:resourcePath).appendingPathComponent("assets/" + fileName)
            .path
        let url = URL(fileURLWithPath: path)
        guard let data = try? Data(contentsOf: url) else {
            assertionFailure("failed to parse excercises data")
            return
        }
        do {
            let jsonObj = try JSON(data: data)
            for (_, exJson): (String, JSON) in jsonObj {
                let ex = Exercise(
                    exJson["name"].string ?? "",
                    ExerciseType(rawValue: Int(exJson["type"].stringValue) ?? 0)
                        ?? ExerciseType.unknown,
                    LevelType(rawValue: Int(exJson["level"].stringValue) ?? 0)
                        ?? LevelType.unknown,
                    exJson["id"].string ?? "",
                    exJson["description"].string ?? "",
                    exJson["imageName"].string ?? "",
                    exJson["videoUrl"].string ?? "",
                    exJson["tags"].string ?? "",
                    exJson["detailsFileName"].string ?? ""
                )
                map[ex.id] = ex
            }
        } catch let error {
            assertionFailure("parse error: \(error.localizedDescription)")
        }
    }
}
