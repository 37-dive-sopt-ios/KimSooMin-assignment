//
//  BaeminFeedViewController.swift
//  sopt-kimsoomin-assignment
//
//  Created by mandoo on 11/9/25.
//

import UIKit
import Then
import SnapKit

final class BaeminFeedViewController: UIViewController {
    
    // MARK: - UI Components
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let headerView = HeaderView()
    
    private let categoryTabView = CategoryTabView()
    private let foodCategoryView = CategoryCollectionView(categories: FoodCategoryModel.mockData)
    private let moreInfoView = MoreInfoView()
    private let lineView = UIView().then {
        $0.backgroundColor = .baeminGray200
    }
    
    private let martCategoryView = CategoryCollectionView(categories: MartCategoryModel.mockData)
    
    private let commercialView = CommercialView()
    
    private let popoularRankLabelView = PopularRankLabelView()
    private let popoularRankCollectionView = PopularRankCollectionView()
    
    
    // MARK: - Lify Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .baeminWhite
        
        setLayout()
    }
    
    
    // MARK: - Layouts
    private func setLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubviews(headerView,categoryTabView, foodCategoryView, lineView, moreInfoView, martCategoryView, commercialView, popoularRankLabelView, popoularRankCollectionView)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.width.equalToSuperview()
        }
        
        headerView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(145)
        }
        
        categoryTabView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(27)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        foodCategoryView.snp.makeConstraints {
            $0.top.equalTo(categoryTabView.snp.bottom).offset(21)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(168)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(foodCategoryView.snp.bottom).offset(21)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        moreInfoView.snp.makeConstraints {
            $0.top.equalTo(lineView)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(34)
            $0.width.equalTo(125)
        }
        
        martCategoryView.snp.makeConstraints {
            $0.top.equalTo(moreInfoView.snp.bottom).offset(31)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(84)
        }
        
        commercialView.snp.makeConstraints {
            $0.top.equalTo(martCategoryView.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(180)
            
        }
        
        popoularRankLabelView.snp.makeConstraints {
            $0.top.equalTo(commercialView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(18)
        }
        
        popoularRankCollectionView.snp.makeConstraints {
            $0.top.equalTo(popoularRankLabelView.snp.bottom)
            $0.leading.equalTo(popoularRankLabelView.snp.leading).offset(20)
            $0.height.equalTo(243)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(100)
        }
    }
}
