//
//  UITextField+Altas.swift
//  Altas
//
//  Created by user198265 on 8/23/21.
//

import UIKit

extension UITextField {
    func setLeftIcon(_ image: UIImage){
        let iconImageView = UIImageView(frame: CGRect(x: 10, y: 5, width: 20, height: 18))
        iconImageView.image = image
        let iconContainerView: UIView = UIView(frame: CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconImageView)
        leftView = iconContainerView
        leftViewMode = .always
    }
}
