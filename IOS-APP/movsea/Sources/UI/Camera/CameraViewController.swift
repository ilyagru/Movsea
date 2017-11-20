//
//  CameraViewController.swift
//  movsea
//
//  Created by Movsea Team on 4/27/16.
//  Copyright © 2017 Movsea Team.
//

import UIKit
import AVFoundation

class CameraViewController: ModalBaseViewController {
    
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var cameraBGView: UIView!
    @IBOutlet weak var cameraContentView: UIView!
    @IBOutlet weak var progressView: UIProgressView!
   
    let videoCaptureOutput = AVCaptureMovieFileOutput()
    let captureSession = AVCaptureSession()
    var previewLayer : AVCaptureVideoPreviewLayer?
    var captureDevice : AVCaptureDevice?
    
    var didStartCapture = false
    var timer:Timer?
    var timerTick: Float = 0
    let timerStep:Float = 0.1
#if DEBUG
    let videoLength:Float = 2
#else
    let videoLength:Float = 7
#endif
    let videoFPS:Int32 = 3
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cameraBGView.addShadow()
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(CameraViewController.onTap(sender:)))
        self.view.addGestureRecognizer(tapGR)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        #if arch(i386) || arch(x86_64)
            openVideoProcessor()
        #else
            prepareCamera()
        #endif
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        previewLayer!.frame = cameraContentView.bounds
    }
    
    @objc func onTap(sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.4, animations: {
            self.popUpView.alpha = 0
            }) { (success) in
               self.popUpView.removeFromSuperview()
        }
        sender.isEnabled = false
    }
    
    
    @IBAction func onStartCamera(_ sender: AnyObject) {
        if self.popUpView != nil {
            UIView.animate(withDuration: 0.4, animations: {
                self.popUpView.alpha = 0
            })
        }
        
        if didStartCapture == false {
            didStartCapture = true
            
            if let videoConnection = videoCaptureOutput.connection(with: AVMediaType.video) {
                var newOrientation: AVCaptureVideoOrientation?
                switch (UIDevice.current.orientation) {
                case .portrait:
                    newOrientation = .portrait
                    break
                case .portraitUpsideDown:
                    newOrientation = .portraitUpsideDown
                    break
                case .landscapeLeft:
                    newOrientation = .landscapeRight
                    break
                case .landscapeRight:
                    newOrientation = .landscapeLeft
                    break
                default :
                    newOrientation = .portrait
                    break
                    
                }
                videoConnection.videoOrientation = newOrientation!
            }
            
            let fileURL = FileManager.getOutputFile()
            videoCaptureOutput.startRecording(to: fileURL!, recordingDelegate: self)
            timer = Timer.scheduledTimer(timeInterval: TimeInterval(timerStep), target:self, selector: #selector(CameraViewController.onTimerChange), userInfo: nil, repeats: true)
        }
    }
    
    @objc func onTimerChange() {
        timerTick += timerStep
        if timerTick <= videoLength {
            progressView.progress = timerTick / videoLength
        } else {
            progressView.progress = 1
            timer?.invalidate()
            videoCaptureOutput.stopRecording()
        }
    }
}

extension CameraViewController {

    func prepareCamera() {
        let devices = AVCaptureDevice.devices()
        for device in devices {
            if ((device as AnyObject).hasMediaType(AVMediaType.video)) {
                if((device as AnyObject).position == AVCaptureDevice.Position.back) {
                    captureDevice = device
                    if captureDevice != nil {
                        beginSession()
                    }
                }
            }
        }
    }
    
    func beginSession() {
        configureDevice()
        
        let device = try! AVCaptureDeviceInput(device: captureDevice!)
        captureSession.sessionPreset = AVCaptureSession.Preset.inputPriority
        captureSession.addInput(device)
        captureSession.addOutput(videoCaptureOutput)
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer!.videoGravity = AVLayerVideoGravity.resizeAspect
        previewLayer!.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        cameraContentView.layer.addSublayer(previewLayer!)
        
        captureSession.startRunning()
    }
    
    func configureDevice() {
        if let device = captureDevice {
            try! device.lockForConfiguration()
            let format = (device.formats)
                .filter { CMFormatDescriptionGetMediaSubType($0.formatDescription) == 875704438 && CMVideoFormatDescriptionGetDimensions($0.formatDescription).height == 540 } // Full range 420f
            if let format = format.first {
                device.activeFormat = format
            }
            device.activeVideoMaxFrameDuration = CMTimeMake(1, videoFPS)
            device.activeVideoMinFrameDuration = CMTimeMake(1, videoFPS)
            device.focusMode = .continuousAutoFocus
            device.unlockForConfiguration()
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if let connection =  self.previewLayer?.connection  {
            let currentDevice: UIDevice = UIDevice.current
            let orientation: UIDeviceOrientation = currentDevice.orientation
            let previewLayerConnection : AVCaptureConnection = connection
            
            if (previewLayerConnection.isVideoOrientationSupported)
            {
                switch (orientation)
                {
                case .portrait:
                    previewLayerConnection.videoOrientation = AVCaptureVideoOrientation.portrait
                    break
                case .landscapeRight:
                    previewLayerConnection.videoOrientation = AVCaptureVideoOrientation.landscapeLeft
                    break
                case .landscapeLeft:
                    previewLayerConnection.videoOrientation = AVCaptureVideoOrientation.landscapeRight
                    break
                case .portraitUpsideDown:
                    previewLayerConnection.videoOrientation = AVCaptureVideoOrientation.portraitUpsideDown
                    break
                    
                default:
                    previewLayerConnection.videoOrientation = AVCaptureVideoOrientation.portrait
                    break
                }
            }
        }
    }
}


extension CameraViewController: AVCaptureFileOutputRecordingDelegate {
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        openVideoProcessor()
    }

    func openVideoProcessor() {
        guard let videoProcessing = R.storyboard.main.searchVideoController() else { return }
        navigationController?.pushViewController(videoProcessing, animated: true)
    }
}



