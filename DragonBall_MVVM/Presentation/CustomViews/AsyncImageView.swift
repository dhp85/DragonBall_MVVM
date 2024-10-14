import UIKit

/// Clase personalizada de UIImageView que carga imágenes de manera asíncrona desde una URL.
final class AsyncImageView: UIImageView {
    
    // MARK: - Propiedades Privadas
    
    /// Trabajo de despacho actual para la carga de la imagen.
    private var workItem: DispatchWorkItem?
    
    // MARK: - Métodos Públicos
    
    /**
     Establece la imagen a partir de una cadena que representa una URL.
     
     - Parameter string: Cadena que contiene la URL de la imagen.
     
     - Note: Este método convierte la cadena en una URL válida y llama al método `setImage(_ url: URL)` para cargar la imagen.
     */
    func setImage(_ string: String) {
        if let url = URL(string: string) {
            setImage(url)
        }
    }
    
    /**
     Establece la imagen a partir de una URL.
     
     - Parameter url: URL de la imagen que se va a cargar.
     
     - Note: Este método descarga la imagen de manera asíncrona y la establece en la UIImageView una vez descargada. Si se llama nuevamente antes de que la carga anterior finalice, la carga anterior será cancelada.
     */
    func setImage(_ url: URL) {
        // Cancela cualquier trabajo de carga anterior en progreso.
        cancel()
        
        // Crea un nuevo DispatchWorkItem para la carga de la imagen.
        let workItem = DispatchWorkItem {
            // Intenta descargar los datos de la imagen.
            let image = (try? Data(contentsOf: url)).flatMap { UIImage(data: $0) }
            print("Cargando imagen desde URL: \(url.absoluteString)")
            
            // Actualiza la imagen en el hilo principal.
            DispatchQueue.main.async { [weak self] in
                self?.image = image
                self?.workItem = nil
            }
        }
        
        // Ejecuta el trabajo en un hilo global de manera asíncrona.
        DispatchQueue.global().async(execute: workItem)
        
        // Almacena el trabajo actual para poder cancelarlo si es necesario.
        self.workItem = workItem
    }
    
    /**
     Cancela la carga de la imagen si está en progreso.
     
     - Note: Este método es útil para evitar cargas innecesarias, especialmente en casos como la reutilización de celdas en una UITableView o UICollectionView.
     */
    func cancel() {
        workItem?.cancel()
        workItem = nil
    }
}
