package lv.ailab.senie.db.repositories

import lv.ailab.senie.db.entities.Book
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.CrudRepository
import org.springframework.data.repository.query.Param

interface BookRepository : CrudRepository<Book, Int> {
    fun findByFullSource(itemCode: String): Book?

    @Query("SELECT b FROM Book b WHERE b.itemCode IS NULL AND b.collectionCode = :code")
    fun findCollection(@Param("code") collectionCode: String): Book?

    @Query("SELECT b FROM Book b WHERE b.itemCode IS NOT NULL AND b.collectionCode = :code")
    fun findAllInCollection(@Param("code") collectionCode: String): List<Book>
}