package lv.tezaurs.senie

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.context.properties.ConfigurationPropertiesScan
import org.springframework.boot.runApplication

const val ROOT_PACKAGE: String = "lv.tezaurs.senie"

@SpringBootApplication(scanBasePackages = [ROOT_PACKAGE])
@ConfigurationPropertiesScan(basePackages = [ROOT_PACKAGE])
class Main

fun main() {
    runApplication<Main>()
}
