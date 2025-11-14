package lv.ailab.senie.rest.controllers

import lv.ailab.senie.db.repositories.BookRepository
import org.springframework.http.HttpStatus
import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.ResponseStatus

@Controller
class BookController(
    private val bookRepo: BookRepository,
) {
    @GetMapping("/books/{code}")
    fun bookMenu(
        @PathVariable("code") code: String,
        model: Model,
    ): String {
        val book = bookRepo.findByItemCode(code) ?: throw BookNotFound(code)
        model.addAttribute("book", book)
        return "book"
    }

    @ResponseStatus(HttpStatus.NOT_FOUND)
    class BookNotFound(code: String) : Exception("Sistēmā nav rakstu darba ar kodu [$code].")

}