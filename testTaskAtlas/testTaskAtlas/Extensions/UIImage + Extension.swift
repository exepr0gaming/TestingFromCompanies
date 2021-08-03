//
//  UIImage + Extension.swift
//  testTaskAtlas
//
//  Created by Курдин Андрей on 01.08.2021.
//

import UIKit

extension UIImage {
	var uncompressedPNGData: Data?      { return self.pngData()        }
	var highestQualityJPEGNSData: Data? { return self.jpegData(compressionQuality: 1.0)  }
	var highQualityJPEGNSData: Data?    { return self.jpegData(compressionQuality: 0.75) }
	var mediumQualityJPEGNSData: Data?  { return self.jpegData(compressionQuality: 0.5)  }
	var lowQualityJPEGNSData: Data?     { return self.jpegData(compressionQuality: 0.25) }
	var lowestQualityJPEGNSData:Data?   { return self.jpegData(compressionQuality: 0.0)  }
}

extension UIImage {
	func resizeWithPercent(percentage: CGFloat) -> UIImage? {
		let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: size.width * percentage, height: size.height * percentage)))
		imageView.contentMode = .scaleAspectFit
		imageView.image = self
		UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
		guard let context = UIGraphicsGetCurrentContext() else { return nil }
		imageView.layer.render(in: context)
		guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
		UIGraphicsEndImageContext()
		return result
	}
	func resizeWithWidth(width: CGFloat) -> UIImage? {
		let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
		imageView.contentMode = .scaleAspectFit
		imageView.image = self
		UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
		guard let context = UIGraphicsGetCurrentContext() else { return nil }
		imageView.layer.render(in: context)
		guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
		UIGraphicsEndImageContext()
		return result
	}
}
