//
//  SearchApiListVC.swift
//  iOSTestAssignment
//
//  Created by Naveed ur Rehman on 25/06/2022.
//

import UIKit
import KafkaRefresh

class SearchApiListVC: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tblView: LoginTableView!
    
    
    // MARK: - Variables
    private let loginVM = LoginVM()
    var login = ""
    var page = 1
    var limit = 9
    enum RefreshPosition {
        case top
        case bottom
    }
    
    var isRefreshing = false
    var refresh_position = RefreshPosition.top
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginVM.delegate = self
        Util.shared.showSpinner()
        loginVM.search(with: login, page_no: page, per_page_limit: limit)
        
        self.tblView.bindHeadRefreshHandler({
            self.refresh_position = .top
            self.isRefreshing = true
            self.page = 1
            self.loginVM.search(with: self.login, page_no: self.page, per_page_limit: self.limit)
        }, themeColor: UIColor.lightGray, refreshStyle: .replicatorCircle)
        
        self.tblView.bindFootRefreshHandler({
            if self.tblView.loginItems.count < self.loginVM.searchResponse?.totalCount ?? 0 {
                self.refresh_position = .bottom
                self.isRefreshing = true
                self.page += 1
                self.loginVM.search(with: self.login, page_no: self.page, per_page_limit: self.limit)
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                    self.tblView.footRefreshControl.endRefreshing()
                })
            }
        }, themeColor: UIColor.lightGray, refreshStyle: .replicatorCircle)
    }

}

extension SearchApiListVC: ViewModelProtocol {
    func didUpdateSearchResult() {
        print("resulk got")
        Util.shared.hideSpinner()
        if self.isRefreshing {
            guard loginVM.searchResponse != nil else {
                return
            }
            if self.refresh_position == .top {
                tblView.loginItems = loginVM.searchResponse?.items ?? []
                tblView.reloadTbl()
            } else {
                for i in (loginVM.searchResponse!.items ?? []) {
                    self.tblView.loginItems.append(i)
                }
                UIView.performWithoutAnimation {
                    self.tblView.reloadData()
                }
            }
            
            self.tblView.footRefreshControl.endRefreshing()
            self.tblView.headRefreshControl.endRefreshing()
            self.isRefreshing = false
        } else {
            tblView.loginItems = loginVM.searchResponse?.items ?? []
            tblView.reloadTbl()
        }
        
    }
}
