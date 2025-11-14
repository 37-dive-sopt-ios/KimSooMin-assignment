//
//  TabBarController.swift
//  sopt-kimsoomin-assignment
//
//  Created by mandoo on 11/11/25.
//

import UIKit

final class EmptyViewController: UIViewController {
    init(backgroundColor: UIColor) {
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class TabBarViewController: UITabBarController {
    
    //MARK: - Properties
    enum BaeminTab: Int, CaseIterable {
        case home = 0
        case shopping
        case heart
        case order
        case mybaemin
        
        var title: String {
            switch self {
            case .home: return "홈"
            case .shopping: return "장보기·쇼핑"
            case .heart: return "찜"
            case .order: return "주문내역"
            case .mybaemin: return "마이배민"
            }
        }
        
        var image: UIImage {
            switch self {
            case .home: return .tab1
            case .shopping: return .tab2
            case .heart: return .tab3
            case .order: return .tab4
            case .mybaemin: return .tab5
            }
        }
        
        var viewController: UIViewController {
            switch self {
            case .home:
                return BaeminFeedViewController()
            case .shopping:
                return EmptyViewController(backgroundColor: .baeminMint300)
            case .heart:
                return EmptyViewController(backgroundColor: .baeminRed)
            case .order:
                return EmptyViewController(backgroundColor: .baeminPurple)
            case .mybaemin:
                return EmptyViewController(backgroundColor: .baeminGray600)
            }
        }
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = BaeminTab.allCases.map { tab in
            return viewController(for: tab.viewController,
                                  title: tab.title,
                                  imageName: tab.image)
        }
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        
        let itemAppearance = UITabBarItemAppearance()
        itemAppearance.normal.iconColor = .lightGray
        itemAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.baeminGray700,
            .font: UIFont.title_sb_10
        ]
        
        itemAppearance.selected.iconColor = .black
        itemAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor.baeminBlack,
            .font: UIFont.body_r_10
        ]
        appearance.stackedLayoutAppearance = itemAppearance
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
    
    
    // MARK: - Functions
    private func viewController(for rootViewController: UIViewController,
                                title: String,
                                imageName: UIImage) -> UIViewController {
        let viewController = UINavigationController(rootViewController: rootViewController)
        viewController.setNavigationBarHidden(true, animated: false)
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = resizeImage(image: imageName)
            .withRenderingMode(.alwaysTemplate)
        return viewController
    }
    
    private func resizeImage(image: UIImage) -> UIImage {
        let size = CGSize(width: 24, height: 24)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        image.draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage!
    }
}
