import UIKit
import WebKit

public enum ConektaError: Error {
    case invalidJSContext
    case invalidResponse
}

public class ConektaTokenError: Decodable, Error {
    public var type: String
    public var message: String
    public var display: String
    public var code: String
    public var param: String?
    
    enum CodingKeys: String, CodingKey {
        case type, message, param, code
        case display = "message_to_purchaser"
    }
}

public class Conekta {
    
    private let scriptURL = URL(string: "https://conektaapi.s3.amazonaws.com/v0.5.0/js/conekta.js")!
    private let baseURI = "https://api.conekta.io"
    let publicKey: String
    let base64PublicKey: String
    
    public init?(publicKey: String) {
        self.publicKey = publicKey
        
        guard let data = publicKey.data(using: .utf8),
              let base = String(data: data.base64EncodedData(options: .lineLength64Characters), encoding: .utf8) else {
            return nil
        }
        base64PublicKey = base
    }
    
    private func deviceFingerprint() -> String {
        return UIDevice.current.identifierForVendor?.uuidString.replacingOccurrences(of: "-", with: "") ?? ""
    }
    
    public func collectDevice(view: UIView) {
        let html = "<html style=\"background: blue;\"><head></head><body><script type=\"text/javascript\" src=\"https://conektaapi.s3.amazonaws.com/v0.5.0/js/conekta.js\" data-conekta-public-key=\"\(publicKey)\" data-conekta-session-id=\"\(deviceFingerprint())\"></script></body></html>"
        let webView = WKWebView(frame: CGRect.zero)
        webView.loadHTMLString(html, baseURL: nil)
        view.addSubview(webView)
    }
    
    public func getToken(for card: Card, completion: @escaping (Token?, Error?) -> Void) throws {
        let url = URL(string: baseURI + "/tokens")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Basic \(base64PublicKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        request.addValue("application/vnd.conekta-v0.3.0+json", forHTTPHeaderField: "Accept")
        request.addValue("{\"agent\":\"Conekta Conekta iOS SDK\"}", forHTTPHeaderField: "Conekta-Client-User-Agent")
        
        request.httpBody = try JSONEncoder().encode(["card": card])
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                if let error = error {
                    throw error
                } else if let data = data {
                    if let error = try? JSONDecoder().decode(ConektaTokenError.self, from: data) {
                        throw error
                    }
                    let token = try JSONDecoder().decode(Token.self, from: data)
                    completion(token, nil)
                } else {
                    throw ConektaError.invalidResponse
                }
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
}
