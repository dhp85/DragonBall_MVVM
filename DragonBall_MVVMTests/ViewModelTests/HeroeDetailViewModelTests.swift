@testable import DragonBall_MVVM
import XCTest

final class HeroeDetailViewModelTests: XCTestCase {

    /// Este método prueba el comportamiento exitoso del HeroeDetailViewModel.
    func testSuccess() {
        // Crear un objeto Hero para usar en la prueba.
        let hero = Hero(id: "1", name: "Goku", description: "", photo: "", favorite: true)
        
        //  Crear una instancia del ViewModel con el héroe creado.
        let sut = HeroeDetailViewModel(heroe: hero)
        
        // Crear una expectativa para esperar el estado de éxito.
        let successExpectation = expectation(description: "Success")
        
        // Vincular el cambio de estado en el ViewModel a una acción.
        sut.onStateChanged.bind { state in
            // Verificar si el estado es el esperado (success) con el héroe correcto.
            if case .success(hero) = state {
                // 6. Cumplir la expectativa si el estado es .success.
                successExpectation.fulfill()
            }
        }
        
        // Llamar al método load() para iniciar la carga del héroe.
        sut.load()
        
        // Esperar a que se cumpla la expectativa durante un tiempo definido.
        waitForExpectations(timeout: 6.0)
        
        // Verificar que el nombre del héroe en el ViewModel coincide con el héroe esperado.
        XCTAssertEqual(sut.heroe.name, hero.name)
    }
}
