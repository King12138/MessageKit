//
//  PhotoMessageCollectionViewCellDefaultStyle.swift
//  MessageKit
//
//  Created by ChenHao on 16/3/3.
//  Copyright © 2016年 HarriesChen. All rights reserved.
//

import Foundation

public class PhotoMessageCollectionViewCellDefaultStyle: PhotoMessageCollectionViewCellStyleProtocol {
    
    private struct Constants {
        let tailWidth: CGFloat = 6.0
        let aspectRatioIntervalForSquaredSize: ClosedInterval<CGFloat> = 0.90...1.10
        let photoSizeLandscape = CGSize(width: 210, height: 136)
        let photoSizePortratit = CGSize(width: 136, height: 210)
        let photoSizeSquare = CGSize(width: 210, height: 210)
        let placeholderIconTintIncoming = UIColor.bma_color(rgb: 0xced6dc)
        let placeholderIconTintOugoing = UIColor.bma_color(rgb: 0x508dfc)
        let progressIndicatorColorIncoming = UIColor.bma_color(rgb: 0x98a3ab)
        let progressIndicatorColorOutgoing = UIColor.whiteColor()
        let overlayColor = UIColor.blackColor().colorWithAlphaComponent(0.70)
    }
    
    lazy private var styleConstants = Constants()
    lazy private var baseStyle = BaseMessageCollectionViewCellDefaultSyle()
    
    lazy private var maskImageIncomingTail: UIImage = {
        return UIImage(named: "bubble-incoming-tail", inBundle: NSBundle(forClass: self.dynamicType), compatibleWithTraitCollection: nil)!
    }()
    
    lazy private var maskImageIncomingNoTail: UIImage = {
        return UIImage(named: "bubble-incoming", inBundle: NSBundle(forClass: self.dynamicType), compatibleWithTraitCollection: nil)!
    }()
    
    lazy private var maskImageOutgoingTail: UIImage = {
        return UIImage(named: "bubble-outgoing-tail", inBundle: NSBundle(forClass: self.dynamicType), compatibleWithTraitCollection: nil)!
    }()
    
    lazy private var maskImageOutgoingNoTail: UIImage = {
        return UIImage(named: "bubble-outgoing", inBundle: NSBundle(forClass: self.dynamicType), compatibleWithTraitCollection: nil)!
    }()
    
    lazy private var placeholderBackgroundIncoming: UIImage = {
        return UIImage.bma_imageWithColor(self.baseStyle.baseColorIncoming, size: CGSize(width: 1, height: 1))
    }()
    
    lazy private var placeholderBackgroundOutgoing: UIImage = {
        return UIImage.bma_imageWithColor(self.baseStyle.baseColorOutgoing, size: CGSize(width: 1, height: 1))
    }()
    
    lazy private var placeholderIcon: UIImage = {
        return UIImage(named: "photo-bubble-placeholder-icon", inBundle: NSBundle(forClass: self.dynamicType), compatibleWithTraitCollection: nil)!
    }()
    
    public func maskingImage(viewModel viewModel: PhotoMessageViewModelProtocol) -> UIImage {
        switch (viewModel.isIncoming, viewModel.showsTail) {
        case (true, true):
            return self.maskImageIncomingTail
        case (true, false):
            return self.maskImageIncomingNoTail
        case (false, true):
            return self.maskImageOutgoingTail
        case (false, false):
            return self.maskImageOutgoingNoTail
        }
    }
    
    public func borderImage(viewModel viewModel: PhotoMessageViewModelProtocol) -> UIImage? {
        return self.baseStyle.borderImage(viewModel: viewModel)
    }
    
    public func placeholderBackgroundImage(viewModel viewModel: PhotoMessageViewModelProtocol) -> UIImage {
        return viewModel.isIncoming ? self.placeholderBackgroundIncoming : self.placeholderBackgroundOutgoing
    }
    
    public func placeholderIconImage(viewModel viewModel: PhotoMessageViewModelProtocol) -> (icon: UIImage?, tintColor: UIColor?) {
        if viewModel.image.value == nil && viewModel.transferStatus.value == .Failed {
            let tintColor = viewModel.isIncoming ? self.styleConstants.placeholderIconTintIncoming : self.styleConstants.placeholderIconTintOugoing
            return (self.placeholderIcon, tintColor)
        }
        return (nil, nil)
    }
    
    public func tailWidth(viewModel viewModel: PhotoMessageViewModelProtocol) -> CGFloat {
        return self.styleConstants.tailWidth
    }
    
    public func bubbleSize(viewModel viewModel: PhotoMessageViewModelProtocol) -> CGSize {
        let aspectRatio = viewModel.imageSize.height > 0 ? viewModel.imageSize.width / viewModel.imageSize.height : 0
        
        if aspectRatio == 0 || self.styleConstants.aspectRatioIntervalForSquaredSize.contains(aspectRatio) {
            return self.styleConstants.photoSizeSquare
        } else if aspectRatio < self.styleConstants.aspectRatioIntervalForSquaredSize.start {
            return self.styleConstants.photoSizePortratit
        } else {
            return self.styleConstants.photoSizeLandscape
        }
    }
    
    public func progressIndicatorColor(viewModel viewModel: PhotoMessageViewModelProtocol) -> UIColor {
        return viewModel.isIncoming ? self.styleConstants.progressIndicatorColorIncoming : self.styleConstants.progressIndicatorColorOutgoing
    }
    
    public func overlayColor(viewModel viewModel: PhotoMessageViewModelProtocol) -> UIColor? {
        let showsOverlay = viewModel.image.value != nil && (viewModel.transferStatus.value == .Transfering || viewModel.status != MessageViewModelStatus.Success)
        return showsOverlay ? self.styleConstants.overlayColor : nil
    }
    
}