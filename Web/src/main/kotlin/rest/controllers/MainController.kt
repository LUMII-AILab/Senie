package lv.ailab.senie.rest.controllers

import lv.ailab.senie.db.entities.Book
import lv.ailab.senie.db.repositories.BookRepository
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class MainController(
    private val bookRepo: BookRepository,
) {
    @GetMapping("")
    fun listBooks(): Iterable<Book> {
        return bookRepo.findAll()
    }
}