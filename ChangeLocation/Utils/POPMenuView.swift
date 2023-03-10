//
//  POPMenuView.swift
//  CustomizationGlass
//
//  Created by 李京珂 on 2021/9/3.
//

import Foundation

import UIKit
// 代理方法，选中事件
protocol POPMenuViewDelegate {
    func POPMenuViewDidSelectedAt(index: Int)
}

enum POPMenueDirection {
    case left
    case right
}

class POPMenuView: UIView {
    var delegate: POPMenuViewDelegate?
    var font: UIFont = UIFont.semibold(14)!
    var direction: POPMenueDirection = .left
    var menuArr: [PopMenu] = .init() {
        didSet {
            tableView.reloadData()
        }
    }

    var orign: CGPoint = .zero
    var cellHeight: CGFloat = 44
    // 分割线颜色
    var separtorColor: UIColor = .black

    var textColor: UIColor = kThemeColor
    // 背景颜色
    var bgColor: UIColor = .white {
        didSet {
            self.tableView.backgroundColor = bgColor
        }
    }

    lazy var tableView: UITableView = {
        let tabV = UITableView(frame: CGRect.zero, style: .plain)
        tabV.backgroundColor = UIColor.white
        tabV.bounces = false
        tabV.layer.cornerRadius = 5
        tabV.delegate = self
        tabV.dataSource = self
        tabV.register(POPMenuViewCell.self, forCellReuseIdentifier: "menuCell")
        return tabV
    }()

    override private init(frame: CGRect) {
        super.init(frame: frame)
    }

    func InitUI() {
        addSubview(tableView)
        tableView.tableFooterView = UIView()
    }

    // 创建
    static func initWith(dataArray: [PopMenu], origin: CGPoint, size: CGSize, direction: POPMenueDirection) -> POPMenuView {
        let menuView = POPMenuView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        menuView.direction = direction
        menuView.orign = origin
        menuView.cellHeight = size.height
        menuView.backgroundColor = UIColor(white: 0.3, alpha: 0.2)

        if direction == POPMenueDirection.left {
            menuView.tableView.frame = CGRect(x: origin.x, y: origin.y, width: size.width, height: size.height * CGFloat(dataArray.count))
        } else {
            menuView.tableView.frame = CGRect(x: origin.x, y: origin.y, width: -size.width, height: size.height * CGFloat(dataArray.count))
        }
        menuView.InitUI()
        menuView.menuArr = dataArray
        menuView.pop()

        return menuView
    }

    func pop() {
        let window = UIApplication.shared.keyWindow
        window?.addSubview(self)
        let frame = tableView.frame
        tableView.frame = CGRect(x: orign.x, y: orign.y, width: 0, height: 0)
        UIView.animate(withDuration: 0.2) {
            self.tableView.frame = frame
        }
    }

    func dismiss() {
        UIView.animate(withDuration: 0.2, animations: {
            self.tableView.frame = CGRect(x: self.orign.x, y: self.orign.y, width: 0, height: 0)
        }) { _ in
            self.removeFromSuperview()
        }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(_: Set<UITouch>, with _: UIEvent?) {
        dismiss()
    }

    override func draw(_: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.beginPath()
        if direction == POPMenueDirection.left {
            let startX = orign.x + 20
            let startY = orign.y
            context?.move(to: CGPoint(x: startX, y: startY)) // 起点
            context?.addLine(to: CGPoint(x: startX + 5, y: startY - 8))
            context?.addLine(to: CGPoint(x: startX + 10, y: startY))
        } else {
            let startX = orign.x - 20
            let startY = orign.y
            context?.move(to: CGPoint(x: startX, y: startY)) // 起点
            context?.addLine(to: CGPoint(x: startX + 5, y: startY - 8))
            context?.addLine(to: CGPoint(x: startX + 10, y: startY))
        }
        context?.closePath() // 结束
        tableView.backgroundColor?.setFill() // 设置填充色
        tableView.backgroundColor?.setStroke()
        context?.drawPath(using: .fillStroke) // 绘制路径
    }
}

extension POPMenuView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return menuArr.count
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return cellHeight
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! POPMenuViewCell
        let menu = menuArr[indexPath.row]
        cell.setupData(menu)
        cell.titleLabel.font = font
        cell.titleLabel.textColor = textColor
        cell.separtorLine.isHidden = (indexPath.row < menuArr.count - 1) ? false : true
        cell.separtorLine.backgroundColor = separtorColor
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.POPMenuViewDidSelectedAt(index: indexPath.row)
    }
}
