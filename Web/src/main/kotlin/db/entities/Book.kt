package lv.ailab.senie.db.entities

import jakarta.persistence.Entity
import jakarta.persistence.Id
import jakarta.persistence.Table
import lv.ailab.senie.utils.urlEncode
import java.net.URLEncoder
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
    val isCollection: Boolean
        get() = collectionCode != null && itemCode == null

    val isCollectionItem: Boolean
        get() = collectionCode != null && itemCode != null

    val urlPath: String
        get() = "/${if (isCollection) "collections" else "books"}/" + fullSource.urlEncode()

    val displayCode: String
        get() = itemCode ?: collectionCode ?: throw Exception(
            "Book [$name]($id) has neither a collection nor item code. " +
                "This should not be possible, data corruption likely.",
        )

    val displayTitle: String
        get() = "$name ($displayCode)"
}