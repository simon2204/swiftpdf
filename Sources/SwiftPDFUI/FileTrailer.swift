import Foundation

struct FileTrailer {
    let dictionary: Dictionary<NamedObject, PDFObject>
    let count: Int
    
    var data: Data {
        var trailerData: Data = "trailer"
        
        trailerData += "startxref"
        trailerData += String(count)
        trailerData += "%%EOF"
        return trailerData
    }
}
