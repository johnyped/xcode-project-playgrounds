import Foundation
import UIKit
import SnapKit

class CustomViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDragDelegate, UICollectionViewDropDelegate {
    
    var collectionView: UICollectionView!
    var items: [String] = ["S1", "S2", "S3", "M", "S4"]
    var sections: [Section] = []
    var dataSource: UICollectionViewDiffableDataSource<UUID, String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = createCompositionalLayout()
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dragDelegate = self
        collectionView.dropDelegate = self
        collectionView.register(SGridCell.self, forCellWithReuseIdentifier: "SGridCell")
        collectionView.register(MGridCell.self, forCellWithReuseIdentifier: "MGridCell")
        collectionView.dragInteractionEnabled = true
        
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        configureDataSource()
        applyInitialSnapshot()
    }
    
    // MARK: - Diffable Data Source
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<UUID, String>(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            return self.configureCell(collectionView: collectionView, indexPath: indexPath, item: item)
        }
    }
    
    private func configureCell(collectionView: UICollectionView, indexPath: IndexPath, item: String) -> UICollectionViewCell? {
        if item == "M" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MGridCell", for: indexPath) as! MGridCell
            cell.configure(with: item)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SGridCell", for: indexPath) as! SGridCell
            cell.configure(with: item)
            return cell
        }
    }
    
    private func applyInitialSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<UUID, String>()
        sections = createSections(from: items)
        for section in sections {
            snapshot.appendSections([section.id])
            snapshot.appendItems(section.items, toSection: section.id)
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func createSections(from items: [String]) -> [Section] {
        var sections: [Section] = []
        
        print("#items")
        print(items)
        
        let layoutRows = createLayoutRows(for: items)
        
        print("#layoutRows:")
        print(layoutRows)
        
        var currentIndex = 0
        for row in layoutRows {
            switch row {
            case .oneSRow:
                sections.append(Section(LayoutRow: .oneSRow,
                                        items: [items[currentIndex]]))
                currentIndex += 1
            case .twoSRow:
                if currentIndex + 1 < items.count {
                    sections.append(Section(LayoutRow: .twoSRow,
                                            items: [items[currentIndex], items[currentIndex + 1]]))
                    currentIndex += 2
                }
            case .mRow:
                sections.append(Section(LayoutRow: .mRow,
                                        items: [items[currentIndex]]))
                currentIndex += 1
            }
        }
        return sections
    }
    
    private func createLayoutRows(for items: [String]) -> [LayoutRow] {
        var layoutRows: [LayoutRow] = []
        var index = 0
        while index < items.count {
            if items[index] == "M" {
                layoutRows.append(.mRow)
                index += 1
            } else if index + 1 < items.count, items[index] != "M", items[index + 1] != "M" {
                layoutRows.append(.twoSRow)
                index += 2
            } else {
                layoutRows.append(.oneSRow)
                index += 1
            }
        }
        return layoutRows
    }
    
    // MARK: - UICollectionViewDragDelegate
    func collectionView(_ collectionView: UICollectionView,
                        itemsForBeginning session: UIDragSession,
                        at indexPath: IndexPath) -> [UIDragItem] {
        let item = dataSource.itemIdentifier(for: indexPath) ?? ""
        let itemProvider = NSItemProvider(object: item as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = item
        return [dragItem]
    }
    
    // MARK: - UICollectionViewDropDelegate
    func collectionView(_ collectionView: UICollectionView,
                        performDropWith coordinator: UICollectionViewDropCoordinator) {
        guard let destinationIndexPath = coordinator.destinationIndexPath else { return }
        
        print("#performDropWith")
        print("destinationIndexPath : (\(destinationIndexPath.section), \(destinationIndexPath.item))")
        
        for item in coordinator.items {
            if let sourceIndexPath = item.sourceIndexPath {
                collectionView.performBatchUpdates({
                    //let movedItem = dataSource.itemIdentifier(for: sourceIndexPath) ?? ""
                    print("before drop item")
                    print(items)
                    print("will drop item at : (\(destinationIndexPath.section),\(destinationIndexPath.item))")
                    print("after drop item")
                    
                    // get item from sourceIndexPath section and tiem
                    let sourceSection = sections[sourceIndexPath.section]
                    let sourceItem = sourceSection.items[sourceIndexPath.item]
                    let sourceItemRef = items.firstIndex(of: sourceItem)
                    
                    // get item from destinationIndexPath section and tiem
                    let destinationSection = sections[destinationIndexPath.section]
                    let destinationItem = destinationSection.items[destinationIndexPath.item]
                    if let destinationItemRef = items.firstIndex(of: destinationItem) {
                        // remove sourceItem from items
                        items.remove(at: sourceItemRef!)
                        
                        //insert sourceItem to items at destinationItemRef
                        items.insert(sourceItem, at: destinationItemRef)
                        print(items)
                    }
                   
                })
                updateSnapshot()
                coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
            } else {
                let itemProvider = item.dragItem.itemProvider
                itemProvider.loadObject(ofClass: NSString.self) { (object, error) in
                    if let string = object as? String {
                        DispatchQueue.main.async {
                            self.items.append(string)
                            self.updateSnapshot()
                        }
                    }
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSString.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        print("#Drop at: (\(destinationIndexPath?.section), \(destinationIndexPath?.item))")
        
        if collectionView.hasActiveDrag {
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        } else {
            return UICollectionViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
        }
    }
    
    // MARK: - Update Snapshot
    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<UUID, String>()
        sections = createSections(from: items)
        for section in sections {
            snapshot.appendSections([section.id])
            snapshot.appendItems(section.items, toSection: section.id)
        }
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    // MARK: - Compositional Layout
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            
            let section = self.sections[sectionIndex]
            switch section.LayoutRow {
            case .oneSRow:
                return self.createSingleSGridCellLayout()
            case .twoSRow:
                return self.createTwoSGridCellLayout()
            case .mRow:
                return self.createMGridCellLayout()
            }
        }
    }
    
    private func createSingleSGridCellLayout() -> NSCollectionLayoutSection {
        let sItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                               heightDimension: .absolute(100))
        let sItem = NSCollectionLayoutItem(layoutSize: sItemSize)
        sItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                               heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: sItem, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 20
        return section
    }
    
    private func createTwoSGridCellLayout() -> NSCollectionLayoutSection {
        let sItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                               heightDimension: .absolute(100))
        let sItem = NSCollectionLayoutItem(layoutSize: sItemSize)
        sItem.contentInsets = NSDirectionalEdgeInsets(top: 10,
                                                      leading: 10,
                                                      bottom: 10,
                                                      trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: sItem,
                                                       count: 2)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 20
        return section
    }
    
    private func createMGridCellLayout() -> NSCollectionLayoutSection {
        let mItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(100))
        let mItem = NSCollectionLayoutItem(layoutSize: mItemSize)
        mItem.contentInsets = NSDirectionalEdgeInsets(top: 10,
                                                      leading: 10,
                                                      bottom: 10,
                                                      trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: mItem,
                                                       count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 20
        return section
    }
    
    enum LayoutRow {
        case oneSRow
        case twoSRow
        case mRow
    }
    
    struct Section {
        let id: UUID
        let LayoutRow: LayoutRow
        let items: [String]
        
        init(LayoutRow: LayoutRow, items: [String]) {
            self.id = UUID()
            self.LayoutRow = LayoutRow
            self.items = items
        }
    }
}

//array extension valueAtIndex(index: Int) -> Any?

