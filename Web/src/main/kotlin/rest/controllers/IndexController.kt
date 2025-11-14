package lv.ailab.senie.rest.controllers

import lv.ailab.senie.db.entities.Book
import lv.ailab.senie.db.repositories.BookRepository
import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.ModelAttribute
import java.util.*

@Controller
class IndexController(
    private val bookRepo: BookRepository,
) {
    @GetMapping("", "/", "/index", "/books")
    fun listBooks(): String = "index"

    @ModelAttribute("booksByCentury")
    fun booksByCentury(): SortedMap<Int, List<Book>> {
        return bookRepo.findAll()
            .filterNot { it.isCollectionItem }
            .groupBy { it.pubCentury }
            .toSortedMap()
    }

}