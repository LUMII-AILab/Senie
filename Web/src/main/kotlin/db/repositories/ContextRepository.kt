package lv.ailab.senie.db.repositories

import lv.ailab.senie.db.entities.Context
import org.springframework.data.repository.CrudRepository

interface ContextRepository : CrudRepository<Context, Int> {
    fun findAllBySourceAndPageSortOrderIn(source: String, pageOrders: Iterable<Int>): List<Context>
}