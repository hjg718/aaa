package team.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
	@RequestMapping("add")
	public String add(){
		return "book/add";
	}
	@RequestMapping("addbook")
	public String add(BookVo vo,Model model,HttpSession session){
		boolean pass = svc.add(vo,session);
		if(pass){
			BookVo book = svc.recent(vo.getBnum());
			model.addAttribute("book", book);
		}
		return "book/recent";
	}
	@RequestMapping("img")
	@ResponseBody
	 public byte[] getImage(HttpServletResponse response, @RequestParam("coverName") String coverName) throws IOException
	 {
	    File file = new File("D:/test/"+coverName);
	    byte[] bytes = org.springframework.util.FileCopyUtils.copyToByteArray(file);
	    response.setContentLength(bytes.length);
	    response.setContentType("image/jpeg");
	    return bytes;
	 }
	
}
