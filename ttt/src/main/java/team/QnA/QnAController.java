package team.QnA;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("qna/")
public class QnAController {
	
	@Autowired
	private QnaService svc;
	
	
	@RequestMapping(value="save",method=RequestMethod.GET)
	public String savef(){
		return "ts/test";
	}
	
	@RequestMapping(value="save",method=RequestMethod.POST)
	@ResponseBody
	public String save(QnaVo vo,HttpSession session){
		String input = svc.save(vo);
		session.setAttribute("userId",vo.getAuthor());
		return input;
	}
	
	@RequestMapping(value = "recent", method = RequestMethod.GET)
	public String recent(QnaVo vo,Model model,HttpSession session){
		String userId = (String)session.getAttribute("userId");
		model.addAttribute("recent",svc.Recent(userId));
		return "ts/recent";
		}
}

