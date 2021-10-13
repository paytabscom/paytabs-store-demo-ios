//
//  NotificationsMessages.swift
//  Rakeb user
//
//  Created by prog_zidane on 5/10/20.
//  Copyright © 2020 Alamat. All rights reserved.
//

import Toast_Swift


public final class NotifiyMessage
{
    private init() {}
    public static let shared = NotifiyMessage()
    public typealias CompletionHandler = () -> Void

    public func configNotify()
    {
        ToastManager.shared.isTapToDismissEnabled = true
        ToastManager.shared.isQueueEnabled = true
        ToastManager.shared.duration = 2
    }
    
    public func toast(toastMessage: String,position: ToastPosition = .bottom, completion: (() -> Void)? = nil)
    {
        configNotify()
        guard let view = UIApplication.getTopViewController()?.view else { return }
        ToastManager.shared.position = position
        view.makeToast(toastMessage) { _ in
            completion?()
        }
    }
}
