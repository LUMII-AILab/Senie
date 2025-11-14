package lv.ailab.senie.rest.controllers

import lv.ailab.senie.db.repositories.BookRepository
import lv.ailab.senie.db.repositories.ContextRepository
import lv.ailab.senie.rest.controllers.CommonFailures.bookNotFound
import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.servlet.view.RedirectView

@Controller
class GotoController(
    private val bookRepo: BookRepository,
    private val contextRepo: ContextRepository,
) {
    @GetMapping("/goto")
    fun goto(
        @RequestParam("source") source: String?,
        @RequestParam("address") address: String?,
    ): RedirectView {
        if (address != null) {
            error("Vēl nav uztaisīts.")
        } else if (source != null) {
            val target = bookRepo.findByFullSource(source)?.urlPath ?: throw bookNotFound(source)
            return RedirectView(target)
        } else throw Exception("`/goto` adresei nepieciešams `address` vai `source` parametrs.")
    }
}