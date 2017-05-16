//
//  ViewController.swift
//  instagram-clone
//
//  Created by Chang ByoungGil on 2017. 5. 2..
//  Copyright © 2017년 Gil. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, SHViewControllerDelegate {
    //선택한 사진 보여주기
    @IBOutlet weak var imageView: UIImageView!
    var image: UIImage?
    
    //사진 선택하기(사진첩 접근)
    @IBAction func buttonPressed(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        
        // 서로다른 클래스 두개 즉 떨어져 있는 두개의 컨트롤러가 서로 명령을 주고받을 수 있게끔 하는 패던.
        imagePickerController.delegate = self
        
        // 카메라와 라이브러리 접근
        imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        // 가져올 사진 자동으로 자르기 기능
        imagePickerController.allowsEditing = false
        
        // self.present(함수)은 controller와 controller를 이어주는segue와 동일한 역할. 외부 라이브러리는 스토리보드에서 구현하기 힘들기에 코드로. xib로 불러와 처리할 수 있게끔 하는 것.
        // completion = self.present 함수가 성공적으로 이루어 졌을때 추가적으로 할 명령을 입력하는것.
        self.present(imagePickerController, animated: true, completion: nil)
        
    }
    
    //필터 선택하기 
    //주석처리(3주차 컬렉션뷰2차 error원인 - 주석처리로 연결이 끊기지 않음. 따로 아래 코드의 연결을 끊어 주어야함.
    
//    @IBAction func filterButtonPressed(_ sender: Any) {
//        let sharakuController = SHViewController(image: imageView.image!)
//        sharakuController.delegate = self
//        self.present(sharakuController, animated: true, completion: nil)
//    }
//    
    //SHViewControllerDelegate를 넣었을때 반드시 구현하라고 하는 함수들.
    //필터선택이 완료 됬을 때. (체크 했을 시 어떤 행동을 할 것인가)
    func shViewControllerImageDidFilter(image: UIImage) {
        //apple develop 사이트의 UIkit 이미지 저장 코드를 따옴.(사진첩에 이미지 저장)
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
    //필터 선택을 취소 했을 때. (취소 했을 시 어떤 행동을 할 것인가)
    func shViewControllerDidCancel() {
        //
    }

    // 사진첩 안에서의 행동을 설정.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // info를 쓰는 이유는 클래스 안의 함수(매소드)를 쓸 때 함수를 호출할 때 쓰는 이유고 함수 안에서 받아서 쓸 때는 info를 씀.
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
            //image를 한번 더 칠 경우 self.를 달아줘야함.
            self.image = image
            
            // 사진첩 내 에서 사진을 선택해도 넘어가지 않음. 사실 지금 ViewController 위에서 작업하고 위에서 delegate의 사용으로 사진첩을 불러온거임. 불러오기만 하고 종료를 설정 안해줘서 dismiss를 설정해줘야함.
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //segue를 스토리보드에서 사용 후 코드 잡업.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FillterSegue" {
            let filterViewController = segue.destination as! FilterViewController
            filterViewController.image = image
        }
    }


}

