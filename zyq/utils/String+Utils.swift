import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }

    func htmlAttributedString() -> NSAttributedString? {
        guard let data = self.data(using: String.Encoding.utf16, allowLossyConversion: false) else {
            assertionFailure("Failed to get data for attributed string")
            return nil
        }
        guard let html = try? NSMutableAttributedString(
            data: data,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType:
                NSAttributedString.DocumentType.html],
            documentAttributes: nil) else {
                assertionFailure("Failed to get html for attributed string")
                return nil
        }
        return html
    }
}
