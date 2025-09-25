package todoapi

import grails.test.mixin.integration.Integration
import spock.lang.Specification
import todoapi.Task

@Integration
abstract class BaseIntegrationSpec extends Specification {

    def setup() {
        // Limpar dados existentes antes de cada teste
        Task.deleteAll()
    }

    def cleanup() {
        // Limpar dados após cada teste
        Task.deleteAll()
    }

}