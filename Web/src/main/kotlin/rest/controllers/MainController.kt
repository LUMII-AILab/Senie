package lv.tezaurs.senie.rest.controllers

import lv.tezaurs.senie.db.entities.Book
import lv.tezaurs.senie.db.repositories.BookRepository
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