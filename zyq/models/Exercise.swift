import Foundation

final class Exercise: ExerciseGroup {
    var id: String
    var description: String
    var imageName: String
    var videoUrl: String
    var tags: String
    var detailsFileName: String

    init(
        _ name: String,
        _ type: Int,
        _ level: Int,
        _ id: String,
        _ description: String,
        _ imageName: String,
        _ videoUrl: String,
        _ tags: String,
        _ detailsFileName: String) {

        self.id = id
        self.description = description
        self.imageName = imageName
        self.videoUrl = videoUrl
        self.tags = tags
        self.detailsFileName = detailsFileName
        
        super.init(name, type, level)
    }

}
