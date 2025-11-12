package lv.ailab.senie.db.repositories

import lv.ailab.senie.db.entities.Book
import org.springframework.data.repository.CrudRepository

interface ContextRepository : CrudRepository<Book, Int>