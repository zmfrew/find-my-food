import UIKit

protocol NetworkInterface {
	func activityDidBegin()
	func activityDidEnd()
}

extension UIApplication: NetworkInterface {
	func activityDidBegin() {
		DispatchQueue.main.async {
			self.isNetworkActivityIndicatorVisible = true
		}
	}
	
	func activityDidEnd() {
		DispatchQueue.main.async {
			self.isNetworkActivityIndicatorVisible = false
		}
	}
}
