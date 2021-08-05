//
//  LFLoginInputView.swift
//  Tool
//
//  Created by mac on 2021/8/3.
//

import UIKit
import SnapKit

class LFLoginInputView: UIView {

    let leftIV :UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    let tf: UITextField = {
        let tf = UITextField()
        return tf
    }()

    let rightView: UIView?
    
    let line: UIView = {
        let l = UIView()
        l.backgroundColor = .black.withAlphaComponent(0.1)
        return l
    }()

    init(leftImage: UIImage, pl: String, _ rightView: UIView?) {
        self.rightView = rightView

        super.init(frame: .zero)
        leftIV.image = leftImage
        self.addSubview(leftIV)
        
        tf.placeholder = pl
        self.addSubview(tf)
        
        self.addSubview(line)
        line.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(0.5 * UIScreen.main.scale)
        }
        
        leftIV.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 20, height: 20))
            make.centerY.equalTo(self)
            make.left.equalTo(9)
        }
        
        if let rightView = self.rightView {
            self.addSubview(rightView)
            tf.snp.makeConstraints { make in
                make.left.equalTo(leftIV.snp.right).offset(15)
                make.height.equalTo(35)
                make.centerY.equalTo(self)
                make.right.equalTo(rightView.snp.left).offset(-10)
            }
            
            rightView.snp.makeConstraints { make in
                make.size.equalTo(CGSize(width: rightView.frame.size.width, height: rightView.frame.size.height))
                make.right.equalTo(self.snp.right).offset(-10)
                make.centerY.equalTo(self)
            }
        }else {
            tf.snp.makeConstraints { make in
                make.left.equalTo(leftIV.snp.right).offset(15)
                make.height.equalTo(35)
                make.centerY.equalTo(self)
                make.right.equalTo(self.snp.right).offset(-10)
            }
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
///2个按钮
class LFLoginMentView: UIView {
    var btns : [UIButton] = []
    
    var clickBlock: ((NSInteger) -> ())?
    
    let line: UIView = {
        let l = UIView(frame: .init(x: 0, y: 0, width: 28, height: 2))
        l.layer.cornerRadius = 1
        l.layer.masksToBounds = true
        l.backgroundColor = .blue
        return l
    }()
    
    init(titles: [String]) {
        super.init(frame: .zero)
        self.addSubview(line)
//        self.titles = titles
        for (i, str) in titles.enumerated() {
            let btn = UIButton()
            btn.setTitle(str, for: .normal)
            btn.setTitleColor(.black, for: .normal)
            btn.setTitleColor(.blue, for: .selected)
            btn.tag = i + 10
            btn.addTarget(self, action: #selector(click(btn:)), for: .touchUpInside)
            self.btns.append(btn)
            self.addSubview(btn)
        
            btn.snp.makeConstraints { make in
                if i == 0 {
                    make.left.equalTo(0)
                    make.right.equalTo(self.snp.centerX).offset(0)
                }else {
                    make.left.equalTo(self.snp.centerX).offset(0)
                    make.right.equalTo(0)
                }
                make.top.bottom.equalTo(self)
            }
            
        }
        let t = btns[0]
        line.snp.makeConstraints { make in
            make.size.equalTo(CGSize.init(width: 28, height: 2))
            make.bottom.equalTo(0)
            make.centerX.equalTo(t.snp.centerX)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func click(btn : UIButton) {
        for t in btns {
            t.isSelected = false
        }
        btn.isSelected = true
        line.snp.remakeConstraints { make in
            make.size.equalTo(CGSize.init(width: 28, height: 2))
            make.bottom.equalTo(0)
            make.centerX.equalTo(btn.snp.centerX)
        }
        UIView.animate(withDuration: 0.15) {
            self.layoutIfNeeded()
            UIView.performWithoutAnimation {
                
            }
        }
        if let blcok = clickBlock {
            blcok(btn.tag - 10)
        }
    }
}
