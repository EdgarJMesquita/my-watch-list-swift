//
//  VideoPlayerViewController.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 20/03/25.
//

import UIKit
import WebKit

class VideoPlayerViewController: UIViewController {
    private let video: Video
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    private lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.allowsInlineMediaPlayback = true
        webConfiguration.preferences.javaScriptEnabled = true
        webConfiguration.defaultWebpagePreferences.allowsContentJavaScript = true
        
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        return webView
    }()
    
    init(video: Video) {
        self.video = video
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadVideoURL()
        setupNavigationItem()
        activityIndicator.startAnimating()
    }
    
    private func loadVideoURL() {
        guard
            let urlString = getUrlString(),
            let url = URL(string: urlString) 
        else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)

        DispatchQueue.main.async { [weak self] in
            self?.webView.load(request)
        }
    }
    
    private func getUrlString() -> String? {
        switch video.site {
            case "YouTube":
                return getYoutubeUrl(videoId: video.key)
            case "Vimeo":
                return getVimeoUrl(vimeoId: video.key)
            default:
                print(video.site)
                return nil
        }
    }
    
    private func getYoutubeUrl(videoId: String) -> String {
        "https://www.youtube.com/embed/\(videoId)"
    }
    
    private func getVimeoUrl(vimeoId: String) -> String {
        "https://player.vimeo.com/video/\(vimeoId)"
    }
    
    private func setupNavigationItem(){
        navigationController?.isNavigationBarHidden = false
 
        let closeButton = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(dismissVC)
        )
        navigationItem.leftBarButtonItem = closeButton
        
    }
    
    
    @objc
    private func dismissVC(){
        dismiss(animated: true)
    }
    
    private func setupUI(){
        setupHierarchy()
        setupConstraints()
        view.backgroundColor = .mwlBackground
    }
    
    private func setupHierarchy(){
        view.addSubview(webView)
        view.addSubview(activityIndicator)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}


extension VideoPlayerViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
}
