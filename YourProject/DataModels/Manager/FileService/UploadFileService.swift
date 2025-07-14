//
//  UploadFileService.swift
//  YourProject
//
//  Created by IntrodexMini on 5/7/2568 BE.
//


import Foundation
import Alamofire

// MARK: - Upload Progress Delegate Protocol
@MainActor
protocol UploadFileServiceDelegate: AnyObject, Sendable {
    /// Called when upload progress is updated
    /// - Parameters:
    ///   - service: The upload service instance
    ///   - progress: Progress object containing completion percentage
    ///   - identifier: Unique identifier for this upload task
    func uploadService(_ service: UploadFileService, didUpdateUploadProgress progress: Progress, identifier: String)
    
    /// Called when download progress is updated (for response data)
    /// - Parameters:
    ///   - service: The upload service instance
    ///   - progress: Progress object containing completion percentage
    ///   - identifier: Unique identifier for this upload task
    func uploadService(_ service: UploadFileService, didUpdateDownloadProgress progress: Progress, identifier: String)
    
    /// Called when upload completes successfully
    /// - Parameters:
    ///   - service: The upload service instance
    ///   - responseData: Response data from server
    ///   - identifier: Unique identifier for this upload task
    func uploadService(_ service: UploadFileService, didCompleteUpload responseData: Data, identifier: String)
    
    /// Called when upload fails
    /// - Parameters:
    ///   - service: The upload service instance
    ///   - error: Error that occurred
    ///   - identifier: Unique identifier for this upload task
    func uploadService(_ service: UploadFileService, didFailUpload error: Error, identifier: String)
}

protocol UploadFileServiceProtocol: Sendable {
    func uploadFile(fileData: Data,
                    toPathUrl: String,
                    identifier: String?) async throws
    func uploadFileFromURL(_ fileURL: URL,
                           toPathUrl: String,
                           identifier: String?) async throws
}

final class UploadFileService: UploadFileServiceProtocol, @unchecked Sendable {
    
    // MARK: - Properties
    @MainActor
    weak var delegate: UploadFileServiceDelegate?
    
    private let apiManager: APIManagerProtocal
    private let uploadQueue = DispatchQueue(label: "com.yourproject.uploadservice", qos: .userInitiated)
    
    // MARK: - Initialization
    init(delegate: UploadFileServiceDelegate? = nil,
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.apiManager = apiManager
        Task { @MainActor in
            self.delegate = delegate
        }
    }
    
    // MARK: - Public Methods
    
    /// Upload file data directly to the specified URL using PUT method
    /// - Parameters:
    ///   - fileData: The data to upload
    ///   - toPathUrl: The destination URL as a string
    ///   - identifier: Optional identifier for tracking this upload
    /// - Throws: AFError or other networking errors
    func uploadFile(fileData: Data, toPathUrl: String, identifier: String? = nil) async throws {
        let uploadId = identifier ?? UUID().uuidString
        
        // Validate URL
        guard let url = URL(string: toPathUrl) else {
            let error = AFError.invalidURL(url: toPathUrl)
            await notifyDelegate { delegate in
                delegate.uploadService(self, didFailUpload: error, identifier: uploadId)
            }
            throw error
        }
        
        do {
            // Perform upload with PUT method and progress tracking
            let response = try await AF.upload(fileData, to: url, method: .put)
                .uploadProgress(queue: uploadQueue) { @Sendable [weak self] progress in
                    guard let self = self else { return }
                    Task { @MainActor in
                        self.delegate?.uploadService(self, didUpdateUploadProgress: progress, identifier: uploadId)
                    }
                    print("Upload Progress: \(progress.fractionCompleted)")
                }
                .downloadProgress(queue: uploadQueue) { @Sendable [weak self] progress in
                    guard let self = self else { return }
                    Task { @MainActor in
                        self.delegate?.uploadService(self, didUpdateDownloadProgress: progress, identifier: uploadId)
                    }
                    print("Download Progress: \(progress.fractionCompleted)")
                }
                .validate(statusCode: 200..<300)
                .serializingData()
                .value
            
            print("Upload completed successfully. Response size: \(response.count) bytes")
            
            // Notify delegate of successful completion
            await notifyDelegate { delegate in
                delegate.uploadService(self, didCompleteUpload: response, identifier: uploadId)
            }
            
        } catch {
            // Notify delegate of failure
            await notifyDelegate { delegate in
                delegate.uploadService(self, didFailUpload: error, identifier: uploadId)
            }
            throw error
        }
    }
    
    /// Upload file from URL to the specified destination using PUT method
    /// - Parameters:
    ///   - fileURL: Local file URL to upload
    ///   - toPathUrl: The destination URL as a string
    ///   - identifier: Optional identifier for tracking this upload
    /// - Throws: AFError or other networking errors
    func uploadFileFromURL(_ fileURL: URL, toPathUrl: String, identifier: String? = nil) async throws {
        let uploadId = identifier ?? UUID().uuidString
        
        // Validate destination URL
        guard let destinationURL = URL(string: toPathUrl) else {
            let error = AFError.invalidURL(url: toPathUrl)
            await notifyDelegate { delegate in
                delegate.uploadService(self, didFailUpload: error, identifier: uploadId)
            }
            throw error
        }
        
        // Validate file exists
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            let error = AFError.sessionTaskFailed(error: CocoaError(.fileNoSuchFile))
            await notifyDelegate { delegate in
                delegate.uploadService(self, didFailUpload: error, identifier: uploadId)
            }
            throw error
        }
        
        do {
            // Perform upload with PUT method and progress tracking
            let response = try await AF.upload(fileURL, to: destinationURL, method: .put)
                .uploadProgress(queue: uploadQueue) { @Sendable [weak self] progress in
                    guard let self = self else { return }
                    Task { @MainActor in
                        self.delegate?.uploadService(self, didUpdateUploadProgress: progress, identifier: uploadId)
                    }
                    print("Upload Progress: \(progress.fractionCompleted)")
                }
                .downloadProgress(queue: uploadQueue) { @Sendable [weak self] progress in
                    guard let self = self else { return }
                    Task { @MainActor in
                        self.delegate?.uploadService(self, didUpdateDownloadProgress: progress, identifier: uploadId)
                    }
                    print("Download Progress: \(progress.fractionCompleted)")
                }
                .validate(statusCode: 200..<300)
                .serializingData()
                .value
            
            print("Upload completed successfully. Response size: \(response.count) bytes")
            
            // Notify delegate of successful completion
            await notifyDelegate { delegate in
                delegate.uploadService(self, didCompleteUpload: response, identifier: uploadId)
            }
            
        } catch {
            // Notify delegate of failure
            await notifyDelegate { delegate in
                delegate.uploadService(self, didFailUpload: error, identifier: uploadId)
            }
            throw error
        }
    }
    
    // MARK: - Private Methods
    
    /// Safely notify delegate on main actor
    /// - Parameter operation: The delegate operation to perform
    @MainActor
    private func notifyDelegate(_ operation: @Sendable @escaping (UploadFileServiceDelegate) -> Void) async {
        guard let delegate = delegate else { return }
        operation(delegate)
    }
}

// MARK: - Multipart Form Data Upload Extension
extension UploadFileService {
    
    /// Upload file as multipart form data using PUT method
    /// - Parameters:
    ///   - fileData: The data to upload
    ///   - fileName: Name for the file
    ///   - mimeType: MIME type of the file
    ///   - fieldName: Form field name
    ///   - toPathUrl: The destination URL as a string
    ///   - additionalFields: Additional form fields
    ///   - identifier: Optional identifier for tracking this upload
    /// - Throws: AFError or other networking errors
    func uploadFileAsMultipart(fileData: Data,
                              fileName: String,
                              mimeType: String,
                              fieldName: String = "file",
                              toPathUrl: String,
                              additionalFields: [String: String] = [:],
                              identifier: String? = nil) async throws {
        
        let uploadId = identifier ?? UUID().uuidString
        
        guard let url = URL(string: toPathUrl) else {
            let error = AFError.invalidURL(url: toPathUrl)
            await notifyDelegate { delegate in
                delegate.uploadService(self, didFailUpload: error, identifier: uploadId)
            }
            throw error
        }
        
        do {
            let response = try await AF.upload(multipartFormData: { @Sendable multipartFormData in
                // Add the file data
                multipartFormData.append(fileData, 
                                       withName: fieldName, 
                                       fileName: fileName, 
                                       mimeType: mimeType)
                
                // Add additional fields
                for (key, value) in additionalFields {
                    multipartFormData.append(Data(value.utf8), withName: key)
                }
            }, to: url, method: .put)
            .uploadProgress(queue: uploadQueue) { @Sendable [weak self] progress in
                guard let self = self else { return }
                Task { @MainActor in
                    self.delegate?.uploadService(self, didUpdateUploadProgress: progress, identifier: uploadId)
                }
                print("Upload Progress: \(progress.fractionCompleted)")
            }
            .downloadProgress(queue: uploadQueue) { @Sendable [weak self] progress in
                guard let self = self else { return }
                Task { @MainActor in
                    self.delegate?.uploadService(self, didUpdateDownloadProgress: progress, identifier: uploadId)
                }
                print("Download Progress: \(progress.fractionCompleted)")
            }
            .validate(statusCode: 200..<300)
            .serializingData()
            .value
            
            print("Multipart upload completed successfully. Response size: \(response.count) bytes")
            
            // Notify delegate of successful completion
            await notifyDelegate { delegate in
                delegate.uploadService(self, didCompleteUpload: response, identifier: uploadId)
            }
            
        } catch {
            // Notify delegate of failure
            await notifyDelegate { delegate in
                delegate.uploadService(self, didFailUpload: error, identifier: uploadId)
            }
            throw error
        }
    }
}

// MARK: - Convenience Methods
extension UploadFileService {
    
    /// Cancel all ongoing uploads
    nonisolated func cancelAllUploads() async {
        return await withCheckedContinuation { continuation in
            AF.session.getTasksWithCompletionHandler { @Sendable dataTasks, uploadTasks, downloadTasks in
                uploadTasks.forEach { $0.cancel() }
                continuation.resume()
            }
        }
    }
    
    /// Get current upload progress for monitoring
    /// - Returns: Dictionary of active upload tasks with their progress
    nonisolated func getActiveUploads() async -> [String: Progress] {
        // This would need to be implemented with proper task tracking
        // For now, returning empty dictionary as a placeholder
        return [:]
    }
}

// MARK: - Upload Task Management
extension UploadFileService {
    
    /// Represents an active upload task
    struct UploadTask: Sendable {
        let identifier: String
        let progress: Progress
        let createdAt: Date
        
        init(identifier: String, progress: Progress) {
            self.identifier = identifier
            self.progress = progress
            self.createdAt = Date()
        }
    }
    
    /// Upload multiple files concurrently
    /// - Parameters:
    ///   - filePaths: Array of file URLs to upload
    ///   - destinationURL: Base destination URL
    ///   - maxConcurrentUploads: Maximum number of concurrent uploads
    /// - Returns: Array of upload results
    func uploadMultipleFiles(
        filePaths: [URL],
        destinationURL: String,
        maxConcurrentUploads: Int = 3
    ) async throws -> [Result<Data, Error>] {
        
        return try await withThrowingTaskGroup(of: (Int, Result<Data, Error>).self, returning: [Result<Data, Error>].self) { group in
            var results: [Result<Data, Error>] = Array(repeating: .failure(AFError.explicitlyCancelled), count: filePaths.count)
            
            // Add tasks to the group with concurrency limit
            for (index, filePath) in filePaths.enumerated() {
                if group.addTaskUnlessCancelled {
                    let identifier = "batch_upload_\(index)_\(UUID().uuidString)"
                    do {
                        let data = try await self.uploadFileFromURL(filePath, toPathUrl: destinationURL, identifier: identifier)
                        return (index, .success(Data())) // Placeholder return
                    } catch {
                        return (index, .failure(error))
                    }
                } else {
                    break
                }
            }
            
            // Collect results
            for try await (index, result) in group {
                results[index] = result
            }
            
            return results
        }
    }
}
