import Foundation
import UIKit

internal struct Task: Hashable, Identifiable {
    let id: UUID;
    var title: String;
    var description: String;
    var status: String;
    var creationDate: Date;
    var completionDate: Date;
}
