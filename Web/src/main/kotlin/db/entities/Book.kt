package lv.ailab.senie.db.entities

import jakarta.persistence.Entity
import jakarta.persistence.Id
import jakarta.persistence.Table
import jakarta.persistence.Transient
import java.time.Year

@Entity
@Table(name = "books")
data class Book(
    @Id val id: Int,
    val fullSource: String,
    val collectionCode: String?,
    val itemCode: String?,
    val name: String,
    val year1: Year,
    val year2: Year,
    val pubCentury: Int,
    val indexType: String?, // TODO: Implement string-enum conversion if possible and use a real enum
    val manuscript: Boolean?,
    val orderInCollection: Int?,
) {
    val isCollectionItem: Boolean
        get() = collectionCode != null && itemCode != null

    val displayCode: String?
        get() = itemCode ?: collectionCode
}