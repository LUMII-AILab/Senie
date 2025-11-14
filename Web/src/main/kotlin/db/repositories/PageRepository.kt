package lv.ailab.senie.db.repositories

import lv.ailab.senie.db.entities.Page
import org.springframework.data.jpa.repository.NativeQuery
import org.springframework.data.repository.CrudRepository

interface PageRepository : CrudRepository<Page, Int> {
    @NativeQuery(BOOK_PAGES_SQL)
    fun findAllPagesInBook(source: String): List<Page>

    companion object {
        const val BOOK_PAGES_SQL = """
            SELECT DISTINCT
                   `page_sort_order` AS `order`,
                   `page` AS `name` 
              FROM `content`
             WHERE `source` = :source
        """
    }
}