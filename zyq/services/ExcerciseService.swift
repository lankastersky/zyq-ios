import Foundation
import SwiftyJSON

final class ExcerciseService {

    private var exercisesMap: [String: Exercise] = [:]
    private let jsonDecoder: JSONDecoder

    init(_ jsonDecoder: JSONDecoder) {
        self.jsonDecoder = jsonDecoder
    }

    convenience init() {
        self.init(JSONDecoder())
    }

    func load() {
        loadExercises(from: "exercises1.json", to: &exercisesMap)
        loadExercises(from: "exercises2.json", to: &exercisesMap)
        loadExercises(from: "exercises3.json", to: &exercisesMap)
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
                    exJson["type"].int ?? 0,
                    exJson["level"].int ?? 0,
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
            print("parse error: \(error.localizedDescription)")
        }
    }
}
