import Foundation

enum ExerciseType: Int {
    //case unknown
    case warmup
    case main
    case supporting
    case closing
    case treatment

    var description: String {
        switch self {
        case .warmup: return "ex_group_warmup".localized
        case .main: return "ex_group_main".localized
        case .supporting: return "ex_group_supporting".localized
        case .closing: return "ex_group_closing".localized
        case .treatment: return "ex_group_treatment".localized
        }
    }
}
