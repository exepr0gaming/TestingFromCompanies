import Foundation

var authCheck: Bool? {
	didSet { UserDefaultsService.shared.authCheck = authCheck ?? false }
}
