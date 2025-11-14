package lv.ailab.senie.rest

object CommonFailures {
    fun bookNotFound(code: String) = Exception("Sistēmā nav rakstu darba ar avota kodu [$code].")

    fun pageNotFound(page: String, source: String) = Exception("Rakstu darbā [$source] nav lappuses [$page].")
}