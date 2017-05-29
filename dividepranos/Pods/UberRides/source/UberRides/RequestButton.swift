//
//  RequestButton.swift
//  UberRides
//
//  Copyright © 2015 Uber Technologies, Inc. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.


import UIKit

// RequestButton implements a button on the touch screen to request a ride.
public class RequestButton: UIButton {
    var deeplink: RequestDeeplink?
    var contentWidth: CGFloat = 0
    var contentHeight: CGFloat = 0
    let padding: CGFloat = 8
    let imageSize: CGFloat = 28
    var buttonStyle: RequestButtonColorStyle
    
    let uberImageView: UIImageView!
    let uberTitleLabel: UILabel!
    
    // initializer to use in storyboard
    required public init?(coder aDecoder: NSCoder) {
        uberImageView = UIImageView()
        uberTitleLabel = UILabel()
        buttonStyle = .Black
        super.init(coder: aDecoder)
        setUp(colorStyle: .Black)
    }
    
    public convenience init() {
        self.init(colorStyle: .Black)
    }
    
    // swift-style initializer
    public init(colorStyle: RequestButtonColorStyle) {
        uberImageView = UIImageView()
        uberTitleLabel = UILabel()
        buttonStyle = colorStyle
        super.init(frame: CGRectZero)
        setUp(colorStyle: colorStyle)
    }
    
    private func setUp(colorStyle: RequestButtonColorStyle) {
        do {
            try setDeeplink()
            addTarget(self, action: "uberButtonTapped:", for: .touchUpInside)
        } catch RequestButtonError.NullClientID {
            print("No Client ID attached to the deeplink.")
        } catch let error {
            print(error)
        }
        
        setContent()
        setConstraints()
        setColorStyle(style: colorStyle)
    }
    
    // build and attach a deeplink to the button
    private func setDeeplink() throws {
        guard RidesClient.sharedInstance.hasClientID() else {
            throw RequestButtonError.NullClientID
        }
        
        let clientID = RidesClient.sharedInstance.clientID
        deeplink = RequestDeeplink(withClientID: clientID!, fromSource: .Button)
    }
    
    /**
     Set the user's current location as a default pickup location.
     */
    public func setPickupLocationToCurrentLocation() {
        if RidesClient.sharedInstance.hasClientID() {
            deeplink!.setPickupLocationToCurrentLocation()
        }
    }
    
    /**
     Set deeplink pickup location information.
     
     - parameter latitude:  The latitude coordinate for pickup
     - parameter longitude: The longitude coordinate for pickup
     - parameter nickname:  Optional pickup location name
     - parameter address:   Optional pickup location address
     */
    public func setPickupLocation(latitude latitude: Double, longitude: Double, nickname: String? = nil, address: String? = nil) {
        if RidesClient.sharedInstance.hasClientID() {
            deeplink!.setPickupLocation(latitude: latitude, longitude: longitude, nickname: nickname, address: address)
        }
    }
    
    /**
     Set deeplink dropoff location information.
     
     - parameter latitude:  The latitude coordinate for dropoff
     - parameter longitude: The longitude coordinate for dropoff
     - parameter nickname:  Optional dropoff location name
     - parameter address:   Optional dropoff location address
     */
    public func setDropoffLocation(latitude latitude: Double, longitude: Double, nickname: String? = nil, address: String? = nil) {
        if RidesClient.sharedInstance.hasClientID() {
            deeplink!.setDropoffLocation(latitude: latitude, longitude: longitude, nickname: nickname, address: address)
        }
    }
    
    /**
     Add a specific product ID to the deeplink. You can see product ID's for a given
     location with the Rides API `GET /v1/products` endpoint.
     
     - parameter productID: Unique identifier of the product to populate in pickup
     */
    public func setProductID(productID: String) {
        if RidesClient.sharedInstance.hasClientID() {
            deeplink!.setProductID(productID: productID)
        }
    }
    
    // add title, image, and sizing configuration
    private func setContent() {
        // add title label
        let bundle = Bundle(forClass: RequestButton.self)
        uberTitleLabel.text = NSLocalizedString("RequestButton.TitleText", bundle: bundle, comment: "Request button description")
        uberTitleLabel.font = UIFont.systemFont(ofSize: 17)
        uberTitleLabel.numberOfLines = 1;
        
        // add image
        let badge = getImage(name: "Badge")
        uberImageView.image = badge
        
        // update content sizes
        let titleSize = uberTitleLabel!.intrinsicContentSize
        contentWidth += titleSize.width + badge.size.width
        contentHeight = max(titleSize.height, badge.size.height)
        
        // rounded corners
        clipsToBounds = true
        layer.cornerRadius = 5
        
        // set to false for constraint-based layouts
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    // get image from media directory
    private func getImage(name: String) -> UIImage {
        let bundle = Bundle(forClass: RequestButton.self)
        let image = UIImage(named: name, inBundle: bundle, compatibleWithTraitCollection: nil)
        return image!
    }
    
    private func setConstraints() {
        addSubview(uberImageView)
        addSubview(uberTitleLabel)
        
        // store constraints and metrics in dictionaries
        let views = ["image": uberImageView!, "label": uberTitleLabel!]
        let metrics = ["padding": padding, "imageSize": imageSize]
        
        // set to false for constraint-based layouts
        uberImageView?.translatesAutoresizingMaskIntoConstraints = false
        uberTitleLabel?.translatesAutoresizingMaskIntoConstraints = false
        
        // prioritize constraints
        uberTitleLabel.setContentCompressionResistancePriority(UILayoutPriorityDefaultLow, for: .horizontal)
        
        // create layout constraints
        let horizontalConstraint: NSArray = NSLayoutConstraint.constraints(withVisualFormat: "H:|-padding-[image(24)]-padding-[label]-padding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views) as NSArray
        let imageVerticalViewConstraint: NSArray = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[image(24)]-|", options: NSLayoutFormatOptions.alignAllLeading, metrics: nil, views: views) as NSArray
        let labelVerticalViewConstraint: NSArray = NSLayoutConstraint.constraints(withVisualFormat: "V:|-padding-[label]-padding-|", options: NSLayoutFormatOptions.alignAllLeading, metrics: metrics, views: views) as NSArray
        
        // add layout constraints
        addConstraints(horizontalConstraint as! [NSLayoutConstraint])
        addConstraints(imageVerticalViewConstraint as! [NSLayoutConstraint])
        addConstraints(labelVerticalViewConstraint as! [NSLayoutConstraint])
    }
    
    // set color scheme, default is black background with white font
    private func setColorStyle(style: RequestButtonColorStyle) {
        buttonStyle = style
        
        switch style {
        case .Black:
            uberTitleLabel.textColor = uberUIColor(color: .UberWhite)
            backgroundColor = uberUIColor(color: .UberBlack)
        case .White :
            uberTitleLabel.textColor = uberUIColor(color: .UberBlack)
            backgroundColor = uberUIColor(color: .UberWhite)
        }
    }
    
    // override to maintain fit-to-content size
    public override func intrinsicContentSize() -> CGSize {
        let width = (3 * padding) + contentWidth
        let height = (2 * padding) + contentHeight
        return CGSizeMake(width, height)
    }
    
    // override to change colors when button is tapped
    override public var isHighlighted: Bool {
        didSet {
            if buttonStyle == .Black {
                if isHighlighted {
                    backgroundColor = uberUIColor(color: .BlackHighlighted)
                } else {
                    backgroundColor = uberUIColor(color: .UberBlack)
                }
            } else if buttonStyle == .White {
                if isHighlighted {
                    backgroundColor = uberUIColor(color: .WhiteHighlighted)
                } else {
                    backgroundColor = uberUIColor(color: .UberWhite)
                }
            }
        }
    }
    
    // initiate deeplink when button is tapped
    public func uberButtonTapped(sender: UIButton) {
        if RidesClient.sharedInstance.hasClientID() {
            deeplink!.build()
            deeplink!.execute()
        }
    }
}

@objc public enum RequestButtonColorStyle: Int {
    case Black
    case White
}

private enum RequestButtonError: Error {
    case NullClientID
}
