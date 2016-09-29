//
//  ViewController.swift
//  outletbox
//
//  Created by angelito on 9/6/15.
//  Copyright (c) 2015 Angelito. All rights reserved.
//


import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var pageViewController: UIPageViewController!
    var sliders: [Slider] = []
    
    @IBOutlet weak var buttonStart: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    // Track the current index
    var currentIndex: Int?
    private var pendingIndex: Int?
  
    override func viewDidLoad()
    {
        super.viewDidLoad()
      
        self.sliders = [
          Slider(title: "Bienvenido", subtitle: "Subtitle 1", image: "logo"),
          Slider(title: "Gana por tus compras", subtitle: "Subtitle 2", image: "gift"),
          Slider(title: "GANA NUEVOS CLIENTES", subtitle: "Subtitle 3", image: "offer-icon")
        ]
      
      
        // Create the page container
        let startVC = self.viewControllerAtIndex(0)! as ContentViewController
        let viewControllers = NSArray(object: startVC)
        pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        pageViewController.delegate = self
        pageViewController.dataSource = self
        pageViewController.setViewControllers(viewControllers as? [UIViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
      
        // Add it to the view
        view.addSubview(pageViewController.view)
        pageControl.numberOfPages = sliders.count
        pageControl.currentPage = 0
        buttonStart.hidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Page View Controller Data Source
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?
    {
      
        let currentIndex = (viewController as! ContentViewController).pageIndex
        if currentIndex == 0 {
          return nil
        }
        let previousIndex = abs((currentIndex - 1) % sliders.count)
        return viewControllerAtIndex(previousIndex)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let currentIndex = (viewController as! ContentViewController).pageIndex
        if currentIndex == sliders.count - 1 {
          return nil
        }
        let nextIndex = abs((currentIndex + 1) % sliders.count)
        return viewControllerAtIndex(nextIndex)
    }
  
  
  func viewControllerAtIndex(index: Int) -> ContentViewController? {
    if index == NSNotFound || index < 0 || index >= sliders.count {
      return nil
    }
    // Create a new view controller and pass suitable data.
    if let vc =
      storyboard?.instantiateViewControllerWithIdentifier("ContentViewController")
        as? ContentViewController {
        let slider = sliders[index]

      vc.imageFile = slider.image
      vc.titleText = slider.title
      vc.subtitleText = slider.subtitle
      vc.pageIndex = index
      return vc
    }
    return nil
  }
  
  func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [UIViewController]) {
    pendingIndex = (pendingViewControllers.first! as! ContentViewController).pageIndex
  }
  
  func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
    if completed {
      currentIndex = pendingIndex
      if let index = currentIndex {
        pageControl.currentPage = index
        if (pageControl.currentPage + 1) == sliders.count {
          buttonStart.hidden = false
        } else {
          buttonStart.hidden = true
        }
      }
    }
  }
}

