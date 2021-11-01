//
//  Extension.swift
//
//
//  Created by Apple on 11/1/21.
//

import Foundation
import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: Double {
        get {
            self.layer.masksToBounds = false
            return Double(self.layer.cornerRadius)
        } set {
            self.layer.cornerRadius = CGFloat(newValue)
        }
    }
    
    @IBInspectable var borderWidth: Double {
        get {
            return Double(self.layer.borderWidth)
        }
        set {
            self.layer.borderWidth = CGFloat(newValue)
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.shadowColor!)
        }
        set {
            self.layer.shadowColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return self.layer.shadowRadius
        }
        set {
            self.layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return self.layer.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
        }
    }
    
    //MARK: viewId
    static var viewId: String {
        return String(describing: self)
    }
}


extension UITableView {
    public func register(_ cell: String) {
        self.register(UINib(nibName: cell, bundle: nil), forCellReuseIdentifier: cell)
    }
    
    public func registerHeaderView(_ header: String) {
        let headerNib = UINib.init(nibName: header, bundle: nil)
        self.register(headerNib, forHeaderFooterViewReuseIdentifier: header)
    }
    
    public func registerFooterView(_ header: String) {
        let headerNib = UINib.init(nibName: header, bundle: nil)
        self.register(headerNib, forHeaderFooterViewReuseIdentifier: header)
    }
    
    public func dequeueReusableCell<T: UITableViewCell>() -> T  {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }

    public func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(for section: Int) -> T  {
        print(T.reuseIdentifier)
        guard let cell = dequeueReusableHeaderFooterView(withIdentifier: "\(T.reuseIdentifier)") as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
    
    public func getIndexPath(_ view: UIView)-> IndexPath? {
        let pointInTable = view.convert(view.bounds.origin, to: self)
        return self.indexPathForRow(at: pointInTable)
    }
}

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewHeaderFooterView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UIButton {
    func applyGradient(colours: [UIColor]) {
        applyGradient(colours: colours, locations: [0])
    }

    func applyGradient(colours: [UIColor], locations: [NSNumber]?) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.name = "gradientLayer"
        
        for layer in layer.sublayers ?? [] {
            if layer.name == "gradientLayer" {
                layer.removeFromSuperlayer()
            }
        }
        
        layer.insertSublayer(gradient, at: 0)
    }
}
