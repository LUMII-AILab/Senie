package lv.tezaurs.senie.db.repositories

import lv.tezaurs.senie.db.entities.Book
import org.springframework.data.repository.CrudRepository

interface BookRepository : CrudRepository<Book, Int>