package team.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import team.QnA.QnaVo;
import team.service.QnaService;

@Controller
@RequestMapping("qb/")
public class QnAController {
	
	@Autowired
	QnaService svc;
	
	
	@RequestMapping(value="save",method=RequestMethod.GET)
	public String savef(){
		return "qna/input";
	}
	
	@RequestMapping(value="save",method=RequestMethod.POST)
	@ResponseBody
	public String save(QnaVo vo,HttpSession session){
		session.setAttribute("userId",vo.getAuthor());
		String input = svc.save(vo);
		return input;
	}
	
	@RequestMapping(value = "recent", method = RequestMethod.GET)
	public String recent(QnaVo vo,Model model,HttpSession session){
		String userId = (String)session.getAttribute("userId");
		System.out.println(userId);
		model.addAttribute("recent",svc.Recent(userId));
		return "qna/recent";
		}
	
	@RequestMapping("list")
	public String list(QnaVo vo,Model model,HttpSession session){
		ArrayList<QnaVo> list = svc.List();
		model.addAttribute("list",list);
		session.setAttribute("curr",1);
		session.setAttribute("total",list.get(0).getTotalpages());
		return "qna/list";
	}
	
	@RequestMapping("page")
	@ResponseBody
	public String getPage(@RequestParam("pgnum") int pgnum){
		String list = svc.getList(pgnum);
		return list;
	}
	
}

