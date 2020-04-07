import Foundation
import SwiftyJSON

final class ExerciseService {

    private var exercises: [Exercise] = []
    private let jsonDecoder: JSONDecoder

    init(_ jsonDecoder: JSONDecoder) {
        self.jsonDecoder = jsonDecoder
    }

    convenience init() {
        self.init(JSONDecoder())
    }

    func load() {
        exercises.removeAll()
        if Utils.isRu() {
            loadExercises(from: "exercises1.json", to: &exercises)
            loadExercises(from: "exercises2.json", to: &exercises)
            loadExercises(from: "exercises3.json", to: &exercises)
        } else {
            loadExercises(from: "exercises1_en.json", to: &exercises)
            loadExercises(from: "exercises2_en.json", to: &exercises)
            loadExercises(from: "exercises3_en.json", to: &exercises)
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
        let closingEx = getExercises(level: level, type: ExerciseType.closing)
        if !closingEx.isEmpty {
            groups.append(ExerciseGroup(
                ExerciseType.closing.description, ExerciseType.closing, level))
        }
        let treatmentEx = getExercises(level: level, type: ExerciseType.treatment)
        if !treatmentEx.isEmpty {
            groups.append(ExerciseGroup(
                ExerciseType.treatment.description, ExerciseType.treatment, level))
        }
        return groups
    }

    public func getExercises(level: LevelType, type: ExerciseType) -> [Exercise] {
        var array = [Exercise]()
        for ex in exercises {
            if (type != .unknown) {
                if (ex.type != type) {
                    continue
                }
            }
            if (ex.level != level) {
                continue
            }
            array.append(ex)
        }
        return array
    }

    public func getPracticeDescription(level: LevelType) -> URL? {
        return getPracticeDescription(level: level, type: .unknown)
    }

    public func getPracticeDescription(level: LevelType, type: ExerciseType) -> URL? {
        return getPracticeDescription(level: level, type: .unknown, name: "")
    }

    public func getPracticeDescription(level: LevelType, type: ExerciseType, name: String) -> URL? {
        let fileName = getPracticeFileName(level: level, type: type, name: name)
        return getAssetsUrl(fileName: fileName)
    }

    public func getAssetsUrl(fileName: String) -> URL? {
        guard let resourcePath = Bundle.main.resourcePath else {
            assertionFailure("failed to get bundle path")
            return nil
        }
        guard Bundle.main.path(forResource: fileName, ofType: nil, inDirectory: "assets") != nil
            else {
             return nil
        }
        let path = URL(fileURLWithPath:resourcePath).appendingPathComponent("assets/" + fileName)
            .path
        return URL(fileURLWithPath: path)
    }

    private func getPracticeFileName(level: LevelType, type: ExerciseType, name: String) -> String {
        var fileName = String(format: "ex_%d", level.rawValue)
        if (type != .unknown) {
            fileName.append(String(format: "_%d", type.rawValue))
        }
        if (!name.isEmpty) {
            fileName.append(String(format: "_%@", name))
        }
        if (!Utils.isRu()) {
            fileName.append("_en")
        }
        fileName.append(".html")
        return fileName
    }

    private func loadExercises(from fileName: String, to array: inout [Exercise]) {
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
                array.append(ex)
            }
        } catch let error {
            assertionFailure("parse error: \(error.localizedDescription)")
        }
    }
}
