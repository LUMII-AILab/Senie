package lv.ailab.senie.rest.controllers

import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.web.bind.annotation.GetMapping

@Controller
class ErrorController {
    @GetMapping("/error")
    fun error(ex: Exception, model: Model): String {
        model.addAttribute("message", ex.message)
        return "error"
    }
}