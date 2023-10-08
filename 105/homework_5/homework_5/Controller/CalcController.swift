//
//  ViewController.swift
//  homework_5
//
//  Created by marwa awwad mohamed awwad on 07.10.2023.
//

import UIKit

class CalcController: UIViewController {
    
    //Mark: - variables
    let viewModel: CalcControllerViewModel
    //Marl: - UI Components
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        
        collectionView.register(CalcHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CalcHeaderCell.identifer)
        
        collectionView.register(ButtonCell.self, forCellWithReuseIdentifier: ButtonCell.identifer)
        
        return collectionView
        
    }()
    //Mark: - lifeCycle
    init(_ viewModel: CalcControllerViewModel = CalcControllerViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
      
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        setupUI()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        //Mark: - second step to avoid crash after clicking on any button
        self.viewModel.updateViews = {[weak self] in
            DispatchQueue.main.async {[weak self] in
                self?.collectionView.reloadData()
                
            }
        }
        
    }
    
    //Mark: - UI Setup
    private func setupUI(){
        self.view.addSubview(self.collectionView)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo:  self.view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo:  self.view.trailingAnchor),
            self.collectionView.topAnchor.constraint(equalTo:  self.view.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo:  self.view.bottomAnchor),
            
        
        ])
        
    }
}

// Mark: - collectionView method
extension CalcController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //Mark: section Header cell
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CalcHeaderCell.identifer, for: indexPath  ) as? CalcHeaderCell else{
            fatalError("failed to dequeue calcHeaderCell in calcController ")
        }
        header.configure(currentCalcText:  self.viewModel.calcHeaderLabel)
      return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let totalCellHeight = view.frame.size.width
         let totalVerticalCellSpacing = CGFloat(10*4)
        let window = view.window?.windowScene?.keyWindow
        let topPadding = window?.safeAreaInsets.top ?? 0
        let bottomPadding = window?.safeAreaInsets.bottom ?? 0
        
        let avilableScreenHeight = view.frame.size.height - topPadding - bottomPadding
        let headerHeight = avilableScreenHeight - totalCellHeight - totalVerticalCellSpacing
        
        return CGSize(width: view.frame.size.width , height: headerHeight)
    }
    //Mark: - normal cells (Buttons)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.calcuttonCells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCell.identifer, for: indexPath ) as? ButtonCell else{
            fatalError("failed to dequeue ButtonCell and calc controller  ")
        }
        let calcButton = self.viewModel.calcuttonCells[indexPath.row]
        cell.configure(with: calcButton )
        return cell
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let calcButton = self.viewModel.calcuttonCells[indexPath.row]
        
        switch calcButton{
        case let .number(int) where int == 0:
            
            return  CGSize(
                width:  (view.frame.size.width/4)*2 ,
                height: view.frame.size.width/5
                )
        default:
            return  CGSize(
                width:  view.frame.size.width/6,
                height: view.frame.size.width/5
                 )
    
          }
        }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return  (self.view.frame.width/5)/3
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
     
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let buttoncall = self.viewModel.calcuttonCells[indexPath.row]
        self.viewModel.didSelectButton(with: buttoncall)
        print(buttoncall.title)
    
        

    }
}
