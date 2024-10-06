@testable import DragonBall_MVVM
import XCTest

final class SplashViewModelTests: XCTestCase {
    
    func testLoadUpdatesStateToLoadingAndReady() {
        // Instancia del ViewModel
        let sut = SplashViewModel()
        
        // Crear una expectativa para esperar las actualizaciones de estado
        let expectationLoading = expectation(description: "loading")
        let expectationReady = expectation(description: "ready")
        
        // Variable para rastrear los estados recibidos
        var caseStates: [SplashState] = []
        
        // Vincular una función al Binding para recibir actualizaciones
        sut.onStateChanged.bind { state in
            caseStates.append(state)
            
            
            if state == .loading {
                expectationLoading.fulfill()
            } else if state == .ready {
                expectationReady.fulfill()
            }
        }
        
        // Llamar al método load()
        sut.load()
        
        // Esperar a que se cumplan las expectativas
        wait(for: [expectationLoading, expectationReady], timeout: 6.0)
        
        // Verificar que los estados recibidos sean los esperados
        XCTAssertEqual(caseStates, [.loading , .ready])
    }
    
}
