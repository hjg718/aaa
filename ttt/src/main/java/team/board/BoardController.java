package team.board;

import java.util.*;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class BoardController {

	@Autowired
	private BoardService svc;
	
	//�Խ��� ù ȭ�� 
	@RequestMapping(value="boardListStart")
	public String boardListStart(Model model){
		Board b = svc.boardFirstPage(1);
		List<BoardVO> list = b.getList();
		
		model.addAttribute("total",b.getTotalpage());
		model.addAttribute("curr", b.getCurrpage());
		model.addAttribute("boardlist",list);
		return "board/boardList";
	}
	//������ ��ȣ
	@RequestMapping("listPage")
	@ResponseBody
	public List<BoardVO> listPage(Model model, @RequestParam("page") int page){
		Board b = svc.boardPage(page);
		List<BoardVO> list = b.getList();
		model.addAttribute("list",list);
		return list;
	}
	//�Խ��� �� ����1
	@RequestMapping("inputPage")
	public String inputPage(Model model, BoardVO board){
		return "board/boardInput";
	}
	//�Խ��� �� ����2
	@RequestMapping(value="boardInput")
	@ResponseBody
	public String input(Model model, BoardVO board){
		boolean ok = svc.input(board);
		JSONObject job = new JSONObject();
		job.put("ok", ok);
		return job.toJSONString();
	}
	//���
	@RequestMapping("boardRepl")
	@ResponseBody
	public String boardRepl(Model model,BoardVO board){
		boolean ok = svc.input(board);
		JSONObject job = new JSONObject();
		job.put("ok", ok);
		return job.toJSONString();
	}
	
	//���� Ŭ���� ���� �о����
	@RequestMapping("info")
	public String info(@RequestParam("num") int num,Model model){
		BoardVO list = svc.info(num);
		model.addAttribute("list",list);
		return "board/boardInfo";
	}
	//����1
	@RequestMapping("edit")
	public String edit(Model model, @RequestParam("num") int num){
		BoardVO list = svc.info(num);
		model.addAttribute("list",list);
		return "board/boardEdit";
	}
	//����2
	@RequestMapping("update")
	@ResponseBody
	public String update(Model model,BoardVO board){
		boolean ok = svc.update(board);
		JSONObject job = new JSONObject();
		job.put("ok",ok);
		return job.toJSONString();
	}
	//����
	@RequestMapping("delete")
	@ResponseBody
	public String delete(Model model , @RequestParam("num") int num){
		boolean ok = svc.delete(num);
		JSONObject job= new JSONObject();
			job.put("ok", ok);
		return job.toJSONString();
	}
	//�˻�
	@RequestMapping("search")
	@ResponseBody
	public String search(Model model,@RequestParam("category") String cat,
									 @RequestParam("keyword") String key){
			String list = svc.search(cat, key);
			return list;
	}
	
	
}
