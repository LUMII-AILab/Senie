package lv.ailab.senie.rest.controllers

object CommonFailures {
    fun bookNotFound(code: String) = Exception("Sistēmā nav rakstu darba ar avota kodu [$code].")
}