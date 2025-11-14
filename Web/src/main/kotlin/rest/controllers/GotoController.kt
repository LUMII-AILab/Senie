package lv.ailab.senie.rest.controllers

import lv.ailab.senie.db.repositories.BookRepository
import lv.ailab.senie.db.repositories.ContentRepository
import lv.ailab.senie.rest.CommonFailures.bookNotFound
import lv.ailab.senie.utils.urlEncode
import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.servlet.view.RedirectView

@Controller
class GotoController(
    private val bookRepo: BookRepository,
    private val contentRepo: ContentRepository,
) {
    @GetMapping("/goto")
    fun goto(
        @RequestParam("source") source: String?,
        @RequestParam("address") address: String?,
        @RequestParam("page") page: String?,
    ): RedirectView {
        if (address != null) {
            error("Vēl nav uztaisīts.")
        } else if (source != null) {
            val target =
                bookRepo.findByFullSource(source)
                    ?.urlPath?.let { path ->
                        if (page != null)
                            "$path?page=${page.urlEncode()}"
                        else path
                    }
                    ?: throw bookNotFound(source)
            return RedirectView(target)
        } else throw Exception("`/goto` adresei nepieciešams `address` vai `source` parametrs.")
    }
}