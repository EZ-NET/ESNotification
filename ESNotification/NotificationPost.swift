//
//  NotificationPost.swift
//  ESNotification
//
//  Created by Tomohiro Kumagai on H27/10/15.
//  Copyright © 平成27年 EasyStyle G.K. All rights reserved.
//

import Foundation

@objc public protocol Postable : _Notification {
	
}

extension Postable {
	
	/// Post the `notification`.
	public func post() {
		
		let notificationCenter = NSNotificationCenter.defaultCenter()
		let rawNotification = self.makeRawNotificationForNativePost()
		
		notificationCenter.postNotification(rawNotification)
	}
	
	/// Create an NSNotification from the `notification`.
	func makeRawNotificationForNativePost() -> NSNotification {
		
		if let notification = self as? RawNotificationType {
			
			return notification.rawNotification
		}
		else {
			
			let name = self.dynamicType.notificationIdentifier
			let object = self
			
			return NSNotification(name: name, object: object, userInfo:nil)
		}
	}
}