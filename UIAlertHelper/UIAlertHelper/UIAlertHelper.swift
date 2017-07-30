//
//  UIAlertHelper.swift
//  POSRetail
//
//  Created by ITG3_8 on 2017/07/27.
//  Copyright © 2017年 インテリジェンス. All rights reserved.
//

import UIKit

class UIAlertHelper: NSObject {
    
    struct PresentAlert {
        var alert: UIAlertController
        var presentVC: UIViewController
        func show() {
            presentVC.present(alert, animated: true, completion: nil)
        }
    }
    
    struct SingleSelectAlert {
        var title: String
        var message: String
        var closure: (() -> Void)?
        
        func make() -> UIAlertController {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            // OK
            alert.addAction(UIAlertAction(title: languagesType.ok,
                                          style: .default,
                                          handler: { _ in if let closure = self.closure { closure()} }))
            return alert
        }
    }
    
    struct DoubleSelectAlert {
        var title: String
        var message: String
        var okClosure: (() -> Void)?
        var cancelClosure: (() -> Void)?
        
        func make() -> UIAlertController {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            // OK
            alert.addAction(UIAlertAction(title: languagesType.ok,
                                          style: .default,
                                          handler: { _ in if let closure = self.okClosure { closure()} }))
            // Cancel
            alert.addAction(UIAlertAction(title: languagesType.cancel,
                                          style: .cancel,
                                          handler: { _ in if let closure = self.cancelClosure { closure() } }))
            return alert
        }
    }
    
    enum AlertTitleType {
        case attention, error, confirm
        var localizedDescription: String {
            switch self {
            case .attention:    return languagesType.attention
            case .error:        return languagesType.error
            case .confirm:      return languagesType.confirm
            }
        }
    }
    
    enum LanguagesType {
        case jp, en
        var ok: String {
            switch self {
            case .jp: return "OK"
            case .en: return "OK"
            }
        }
        var cancel: String {
            switch self {
            case .jp: return "キャンセル"
            case .en: return "Cancel"
            }
        }
        var attention: String {
            switch self {
            case .jp: return "注意"
            case .error: return "attention"
            }
        }
        var error: String {
            switch  self {
            case .jp: return "エラー"
            case .en: return "Error"
            }
        }
        var confirm: String {
            switch self {
            case .jp: return "確認"
            case .confirm: return "confirm"
            }
        }
    }
    
    var titleType: AlertTitleType!
    var message: String!
    var languagesType: LanguagesType!

    required init(titleType: AlertTitleType, message: String, languagesType: LanguagesType) {
        self.titleType = titleType
        self.message = message
        self.languagesType = languagesType
    }
    
    func makeSingleAlert(_ viewController: UIViewController, closure: (() -> Void)?) -> PresentAlert {
        return PresentAlert.init(alert: SingleSelectAlert(title: titleType.localizedDescription,
                                                          message: message,
                                                          closure: closure).make(),
                                 presentVC: viewController)
    }
    
    func makeDoubleAlert(_ viewController: UIViewController, okClosure: (() -> Void)?, cancelClosure: (() -> Void)?) -> PresentAlert {
        return PresentAlert.init(alert: DoubleSelectAlert(title: titleType.localizedDescription,
                                                          message: message,
                                                          okClosure: okClosure,
                                                          cancelClosure: cancelClosure).make(),
                                 presentVC: viewController)
    }
    
    deinit {
        print("UIAlert Helper deinit")
    }
}
