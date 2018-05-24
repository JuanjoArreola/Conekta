import Foundation

public class Token: Decodable {
    public var id: String
    
    init(id: String) {
        self.id = id
    }
}
