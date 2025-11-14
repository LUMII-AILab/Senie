package lv.ailab.senie.db.repositories

import lv.ailab.senie.db.entities.Content
import org.springframework.data.repository.CrudRepository

interface ContentRepository : CrudRepository<Content, Int> {
    fun findAllBySourceAndPageSortOrderIn(source: String, pageOrders: Iterable<Int>): List<Content>
}