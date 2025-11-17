//
//  CategoryCollectionView.swift
//  sopt-kimsoomin-assignment
//
//  Created by mandoo on 11/10/25.
//

import UIKit
import Then
import SnapKit

final class CategoryCollectionView: UIView {
    
    // MARK: - Properties
    private let lineSpacing: CGFloat = 12
    private let interSpacing: CGFloat = 8
    private let numberOfItemsInRow: CGFloat = 5
    private let cellHeight: CGFloat = 78
    
    private var categories: [CategoryData]
    

    // MARK: - UI Components
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout().then {
            $0.scrollDirection = .vertical
            $0.minimumLineSpacing = lineSpacing
            $0.minimumInteritemSpacing = interSpacing
            $0.sectionInset = .zero
        }
    ).then {
        $0.backgroundColor = .white
    }
    
    
    // MARK: - Lify Cycle
    init(categories: [CategoryData]) {
            self.categories = categories
            super.init(frame: .zero)
            self.backgroundColor = .white
        
            setLayout()
            setDelegate()
            register()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    
    // MARK: - Layouts
    private func setLayout() {
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    
    // MARK: - Functions
    private func register() {
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
    }
    
    private func setDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}


// MARK: - UICollectionViewDelegate
extension CategoryCollectionView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(categories[indexPath.item].name)")
    }
}


// MARK: - UICollectionViewDataSource
extension CategoryCollectionView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell else {
            return UICollectionViewCell()
        }
        cell.configure(category: categories[indexPath.item])
        return cell
    }
}


// MARK: - UICollectionViewDelegateFlowLayout
extension CategoryCollectionView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = 62
        let height: CGFloat = cellHeight
        
        return CGSize(width: width, height: height)
    }
}
