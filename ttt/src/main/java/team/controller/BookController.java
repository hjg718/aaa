package team.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import team.book.model.BookVo;
import team.service.BookService;

@Controller
@RequestMapping("book")
public class BookController {

	@Autowired
	BookService svc;
	
	@RequestMapping("search")
	public ModelAndView search(@RequestParam("keyword")String keyword, @RequestParam("category")String category){
		List<BookVo> list= svc.search(keyword, category);
		return new ModelAndView("book/searchresult","list",list);
	}
}
