package lv.ailab.senie.utils

import java.net.URLEncoder

fun String.urlEncode(): String = URLEncoder.encode(this, Charsets.UTF_8)