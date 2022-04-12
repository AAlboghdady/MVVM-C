//
//  UIStoryboardExtension.swift
//  MVVM-C
//
//  Created by Abdurrahman Alboghdady on 12/04/2022.
//

import UIKit

extension UIStoryboard {
    class func instantiateInitialViewController(_ board: StoryBoards) -> UIViewController {
        let story = UIStoryboard(name: board.rawValue, bundle: nil)
        return story.instantiateInitialViewController()!
    }
    
    class func instantiate(_ storyboard: StoryBoards, _ vc: StoryBoardVCIds) -> UIViewController {
        let story = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        return story.instantiateViewController(withIdentifier: vc.rawValue)
    }
}
